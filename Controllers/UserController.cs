
using Microsoft.AspNetCore.Mvc;
using WebCamServer.Dtos;
using WebCamServer.Services.Interfaces;

namespace WebCamServer.Controllers
{
  [Route("api/v1/user")]
  [ApiController]
  public class UserController : ControllerBase
  {
    private readonly IUserService _service;
    private readonly ILogger<UserController> _logger;

    public UserController(ILogger<UserController> logger, IUserService service)
    {
      _logger = logger;
      _service = service;
    }

    [HttpPost]
    public async Task<IActionResult> CreateUser(UserToCreateDto create)
    {
      try
      {
        if(await _service.ExistName(create.Name))
          return BadRequest("El nombre ya esta registrado");

          
        if(await _service.ExistEmail(create.Email))
          return BadRequest("El email ya esta registrado");

        var user = await _service.Create(create);
        return Ok(user);
      }catch(Exception err)
      {
        _logger.LogTrace(err.StackTrace);
        _logger.LogError(err.Message);
        return BadRequest("Algo fallo al crear al usuario");
      }
    }

    
    [HttpPut("{userId}")]
    public async Task<IActionResult> UpdateUser(int userId, [FromBody] UserToUpdateDto update)
    {
      try
      {
        var user = await _service.UpdateUser(userId, update);
        return Ok(user);
      }catch(Exception err)
      {
        _logger.LogTrace(err.StackTrace);
        _logger.LogError(err.Message);
        return BadRequest("Algo fallo al actualizar al usuario");
      }
    }
    
    [HttpGet("{userId}")]
    public async Task<IActionResult> GetUser(int userId)
    {
      try
      {
        var user = await _service.GetById(userId);
        return Ok(user);
      }catch(Exception err)
      {
        _logger.LogTrace(err.StackTrace);
        _logger.LogError(err.Message);
        return BadRequest("Algo fallo al traer usuario");
      }
    }

    // [HttpGet("list")]
    // public async Task<IActionResult> GetListUser()
    // {
    //   try
    //   {
    //     var users = await _service.GetList();
    //     return Ok(users);
    //   }catch(Exception err)
    //   {
    //     _logger.LogTrace(err.StackTrace);
    //     _logger.LogError(err.Message);
    //     return BadRequest("Algo fallo al listar usuarios");
    //   }
    // }
    
    [HttpDelete("{userId}")]
    public async Task<IActionResult> DeleteUser(int userId)
    {
      try
      {
        await _service.Drop(userId);
        return Ok("Eliminado correctamente");
      }catch(Exception err)
      {
        _logger.LogTrace(err.StackTrace);
        _logger.LogError(err.Message);
        return BadRequest("Algo fallo al eliminar al usuario");
      }
    }

  }
}