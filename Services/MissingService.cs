using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using WebCamServer.Dtos;
using WebCamServer.Helpers;
using WebCamServer.Models;
using WebCamServer.Repositories.Interfaces;
using WebCamServer.Services.Interfaces;

namespace WebCamServer.Services
{
  public class MissingService : IMissingService
  {
    private readonly IMissingRepository _repo;
    private readonly IDetectIAService _detectIAServ;
    private readonly IFileService _fileServ;
    private readonly IMapper _mapper;
    public MissingService(IMissingRepository repo, IMapper mapper, IDetectIAService detectIAServ, IFileService fileServ)
    {
      _repo = repo;
      _mapper = mapper;
      _detectIAServ = detectIAServ;
      _fileServ = fileServ;
    }
    public async Task<bool> UpdatePhotosMissing(int missingId, MissingPhotosType type)
    {
      var missing = await _repo.GetById(missingId);
      
      switch (type)
      {
        case MissingPhotosType.Front:
          missing.PhotosFront = true;
          break;
        
        case MissingPhotosType.Rigth:
          missing.PhotosRigth = true;
          break;
        
        case MissingPhotosType.Left:
          missing.PhotosLeft = true;
          break;
        
        default: return false;
      }

      await _repo.Update(missing);

      return true;      
    }

    public async Task<MissingResponseDto> RegisterMissing(MissingToCreateDto create)
    {
      var created = _mapper.Map<Missing>(create);
      await _repo.Create(created);
      return _mapper.Map<MissingResponseDto>(created);
    }
    
    public async Task<bool> ValidatePhotos(MissingPhotosType type, int userId, int missingId)
    {
      string file_type = ConstantsValueSystem.GetStrMissingPhotosType(type);
      string pathPhotos = Path.Combine(
        Directory.GetCurrentDirectory(),
        $"Temp/{userId}/{missingId}/{file_type}"
      );
      
      if (Directory.Exists(pathPhotos))
      {
        string[] files = Directory.GetFiles(pathPhotos);
        foreach (var file in files)
        {
          string result = await _detectIAServ.DetectFacePose(file);
          Console.WriteLine(result);
          if(result != file_type) return false; 
        }
      }
      else return false;

      return true;
    }

    public bool RemovePhotosError(int userId, int missingId, bool temp)
    {
      string path_missing = $"{userId}/{missingId}";
      string path = Path.Combine(
        Directory.GetCurrentDirectory(), 
        ConstantsValueSystem.NameFolderMissigns(),
        path_missing
      );

      string path_temp = Path.Combine(Directory.GetCurrentDirectory(), $"Temp/{path_missing}");
      string path_delete = temp ? path_temp : path;
      try
      {
        // Elimina la carpeta y su contenido
        if (Directory.Exists(path_delete))
        {
          Directory.Delete(path_delete, true);
          Console.WriteLine("La carpeta ha sido eliminada exitosamente.");
          return true;
        }
        else
        {
          Console.WriteLine("La carpeta no existe.");
          return false;
        }
      }
      catch (Exception ex)
      {
        Console.WriteLine("Error al eliminar la carpeta: " + ex.Message);
        return false;
      }
    }

    public async Task<bool> SavePhotosMissing(MissingPhotosType type, MissingToPhotosDto missingPhotos, int userId, bool temp)
    {
      var photos = missingPhotos.Photos;
      string file_type = ConstantsValueSystem.GetStrMissingPhotosType(type);
      string path_missing = $"{userId}/{missingPhotos.MissingId}/{file_type}";
      string path = Path.Combine(
        Directory.GetCurrentDirectory(), 
        ConstantsValueSystem.NameFolderMissigns(),
        path_missing
      );

      string path_temp = Path.Combine(Directory.GetCurrentDirectory(), $"Temp/{path_missing}");
      string path_use = temp ? path_temp : path;
        
      if (Directory.Exists(path_use)) Directory.Delete(path_use, true);

      for (int i = 0; i < photos.Length; i++)
      { 
        var savePhotos = new MissingToSaveDto
        {
          File = photos[i],
          NameFile = $"missing_{file_type}_{i}{Path.GetExtension(photos[i].FileName)}",
        };
        await _fileServ.UploadLocalFile(savePhotos, path_use);
      }

      return true;
    }

    public async Task<List<MissingToListDto>> GetListMissings(int seekerId) =>
      _mapper.Map<List<MissingToListDto>>(await _repo.GetList(seekerId));

    public async Task<byte[]> GetZipFilesMissing(int userId, int missingId,MissingPhotosType type)
    {
      string file_type = ConstantsValueSystem.GetStrMissingPhotosType(type);
      string folderPath = Path.Combine(
        Directory.GetCurrentDirectory(), 
        ConstantsValueSystem.NameFolderMissigns(),
        $"{userId}/{missingId}/{file_type}"
      );

      return await _fileServ.GetZipOfFilesOfFolder(folderPath);
    }
    
    public async Task<MissingDetailDto> UpdateMissing(MissingToUpdateDto update)
    {
      var missing = await _repo.GetById(update.MissingId);
      missing.BirthDate = update.BirthDate;
      missing.MissingDate = update.MissingDate;
      missing.FullName = update.FullName;
      missing.Size = update.Size;
      missing.Gender = update.Gender;
      missing.Description = update.Description;
      missing.LastSeenMap = update.LastSeenMap;
      
      await _repo.Update(missing);
      return _mapper.Map<MissingDetailDto>(missing);
    }
    public async Task<bool> DeleteMissing(int missingId)
    {
      var missing = await _repo.GetById(missingId);
      if(missing == null) return false;
      await _repo.Drop(missing);
      return true;
    }

    public async Task<List<MissingToListSingleDto>> ListSingleMissing(int seekerId) =>
      _mapper.Map<List<MissingToListSingleDto>>(await _repo.GetList(seekerId));


    public async Task<bool> GenerateModelNextToPhotos(int userId, int missingId)
    {
      var missing = await _repo.GetById(missingId);
      if(missing == null) return false;
      
      if(
        missing.PhotosFront &&
        missing.PhotosRigth &&
        missing.PhotosLeft)
      {
        string path_missing = $"{userId}/{missing.Id}";
        string path = Path.Combine(
          Directory.GetCurrentDirectory(), 
          ConstantsValueSystem.NameFolderMissigns(),
          path_missing
        );
        bool created = await _detectIAServ.GenerateModel($"missing_{missingId}_{DateTime.Now.Second}", "keras", path);
        if(!created) return false;

        return true;
      }
      
      return false;
    }
  }
}