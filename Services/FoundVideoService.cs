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
    private readonly IMapper _mapper;
    public FoundVideoService(IFoundVideoRepository repo, IMapper mapper)
    {
      _repo = repo;
      _mapper = mapper;
    }

    public async Task<List<FoundToListDto>> ListOfVideoMissing(int missingId) =>
      _mapper.Map<List<FoundToListDto>>(await _repo.GetByMissingId(missingId));


    public async Task<FoundDetailDto> Create(FoundToCreateDto create)
    {
      var create_mapper = _mapper.Map<FoundVideo>(create);

      await _repo.Create(create_mapper);

      return _mapper.Map<FoundDetailDto>(create_mapper);
    }
  }
}