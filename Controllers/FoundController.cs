
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WebCamServer.Services.Interfaces;

namespace WebCamServer.Controllers
{
  [Route("api/[controller]")]
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
    [HttpGet("{missingId}")]
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
  }
}