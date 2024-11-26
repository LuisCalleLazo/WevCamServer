using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WebCamServer.Dtos;
using WebCamServer.Services.Interfaces;

namespace WebCamServer.Controllers
{
  [Authorize]
  [Route("v1/api/camera")]
  [ApiController]
  public class CameraController : ControllerBase
  {
    private string message_error = "Hubo un error, consulte con el administrador";
    private readonly ILogger<FoundController> _logger;
    private readonly ICameraService _service;
    public CameraController(ILogger<FoundController> logger, ICameraService service)
    {
      _logger = logger;
      _service = service;
    }

    [HttpPost]
    public async Task<ActionResult> GetTModels(CameraToCreateDto create)
    {
      try
      {
        var user_id = User.FindFirst("id")?.Value;
        if(user_id == null) Unauthorized("El usuario no es reconocido");
        int userId = Int32.Parse(user_id);

        create.CreateUserId = userId;
        var created = await _service.Create(create);
        return Ok(created);
      }catch(Exception err)
      {
        _logger.LogError(err.Message);
        Console.WriteLine(err.StackTrace);
        return BadRequest(message_error);
      }
    }
  }
}