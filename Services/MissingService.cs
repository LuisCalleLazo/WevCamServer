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
    private readonly IMapper _mapper;
    public MissingService(IMissingRepository repo, IMapper mapper)
    {
      _repo = repo;
      _mapper = mapper;
    }

    public async Task<MissingResponseDto> RegisterMissing(MissingToCreateDto create)
    {
      var created = _mapper.Map<Missing>(create);
      await _repo.Create(created);
      return _mapper.Map<MissingResponseDto>(created);
    }

    
    public async Task<bool> ValidatePhotos(IFormFile[] photos, MissingPhotosType type)
    {
      
      switch (type)
      {
        case MissingPhotosType.Left:
          break;
          
        case MissingPhotosType.Rigth:
          break;

        case MissingPhotosType.Front:
          break;
        
        default:
          break;
      }

      return true;
    }

  }
}