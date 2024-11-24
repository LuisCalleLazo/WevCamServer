
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace WebCamServer.Controllers
{
  [Route("api/[controller]")]
  [ApiController]
  public class FoundController : ControllerBase
  {
    private string message_error = "Hubo un error, consulte con el administrador";
    private readonly ILogger<FoundController> _logger;
    public FoundController(ILogger<FoundController> logger)
    {
      _logger = logger;
    } 

    [Authorize]
    [HttpGet]
    public async Task<IActionResult> GetFoundVideoList()
    {
      try
            {
        return Ok("asdasd");

      }catch(Exception err)
      {
        _logger.LogError(err.Message);
        Console.WriteLine(err.StackTrace);
        return BadRequest(message_error);
      }
    }  
  }
}