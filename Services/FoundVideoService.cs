using AutoMapper;
using WebCamServer.Dtos;
using WebCamServer.Models;
using WebCamServer.Repositories.Interfaces;
using WebCamServer.Services.Interfaces;

namespace WebCamServer.Services
{
  public class FoundVideoService : IFoundVideoService
  {
    private readonly IFoundVideoRepository _repo;
    private readonly IFileService _fileServ;
    private readonly IMapper _mapper;
    public FoundVideoService(IFoundVideoRepository repo, IMapper mapper, IFileService fileServ)
    {
      _repo = repo;
      _mapper = mapper;
      _fileServ = fileServ;
    }

    public async Task<List<FoundToListDto>> ListOfVideoMissing(int missingId) =>
      _mapper.Map<List<FoundToListDto>>(await _repo.GetListAll());


    public async Task<FoundDetailDto> Create(FoundToCreateDto create)
    {
      var create_mapper = _mapper.Map<FoundVideo>(create);

      await _repo.Create(create_mapper);

      return _mapper.Map<FoundDetailDto>(create_mapper);
    }

    
    public  async Task<byte[]> GetImgsFound(int foundId)
    {
      var found = await _repo.GetById(foundId);
      var list_founds = _fileServ.GetImagesOfFound(found);
      return await _fileServ.GetZipOfFilesOfListFiles(list_founds);
    }
  }
}