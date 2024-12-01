
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WebCamServer.Dtos;
using WebCamServer.Services.Interfaces;

namespace WebCamServer.Controllers
{
  [Route("api/v1/found")]
  [ApiController]
  public class FoundController : ControllerBase
  {
    private string message_error = "Hubo un error, consulte con el administrador";
    private readonly ILogger<FoundController> _logger;
    private readonly IFoundVideoService _service;
    public FoundController(ILogger<FoundController> logger, IFoundVideoService service)
    {
      _logger = logger;
      _service = service;
    } 

    [Authorize]
    [HttpGet("list/{missingId}")]
    public async Task<IActionResult> GetFoundVideoList(int missingId)
    {
      try
      {
        var founds = await _service.ListOfVideoMissing(missingId);
        return Ok(founds);
      }catch(Exception err)
      {
        _logger.LogError(err.Message);
        Console.WriteLine(err.StackTrace);
        return BadRequest(message_error);
      }
    }  

    [HttpPost]
    public async Task<IActionResult> CreateFound(FoundToCreateDto create)
    {
      try
      {
        var created = await _service.Create(create);
        return Ok(created);
      }catch(Exception err)
      {
        _logger.LogError(err.Message);
        Console.WriteLine(err.StackTrace);
        return BadRequest(message_error);
      }
    }  

    
    [HttpGet("{foundId}")]
    public async Task<IActionResult> GetFoundMp4(int foundId)
    {
      try
      {
        var response = await _service.GetImgsFound(foundId);
        if(response == null)
          return BadRequest("No existen las imagenes");
        
        return File(response, "application/zip", "files_missing.zip");
      }catch(Exception err)
      {
        _logger.LogError(err.Message);
        Console.WriteLine(err.StackTrace);
        return BadRequest(message_error);
      }
    }  
  }
}