using AutoMapper;
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

    public async Task<MissingResponseDto> RegisterMissing(MissingToCreateDto create)
    {
      var created = _mapper.Map<Missing>(create);
      await _repo.Create(created);
      return _mapper.Map<MissingResponseDto>(created);
    }
    
    public bool ValidatePhotos(IFormFile[] photos, MissingPhotosType type, int userId, int missingId)
    {
      string file_type = ConstantsValueSystem.GetStrMissingPhotosType(type);
      string pathPhotos = Path.Combine(Directory.GetCurrentDirectory(), $"Missing/{userId}/{missingId}/{file_type}");
      
      if (Directory.Exists(pathPhotos))
      {
        string[] files = Directory.GetFiles(pathPhotos);
        foreach (var file in files)
        {
          string result = _detectIAServ.DetectFacePose(file);
          Console.WriteLine($"Resultado: {result}, El Tipo es: {file_type}");
          if(result != file_type) return false; 
        }
      }
      else return false;

      return true;
    }

    public async Task<bool> SavePhotosMissing(MissingPhotosType type, MissingToPhotosDto missingPhotos)
    {
      var photos = missingPhotos.Photos;

      string file_type = ConstantsValueSystem.GetStrMissingPhotosType(type);
      for (int i = 0; i < photos.Length; i++)
      { 
        var savePhotos = new MissingToSaveDto
        {
          File = photos[i],
          Type = type,
          MissingId = missingPhotos.MissingId,
          UserId = missingPhotos.UserId,
          NameFile = photos[i].FileName,
        };
        await _fileServ.UploadLocalFile(savePhotos);
      }

      return true;
    }

  }
}