using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WebCamServer.Dtos.Notification;
using WebCamServer.Services.Interfaces;
//using WebCamServer.Models;

namespace WebCamServer.Controllers
{
  [Route("api/v1/notification")]
  [ApiController]
  public class NotificationController : ControllerBase
  {
    
    private string message_error = "Hubo un error, consulte con el administrador";
    private readonly IUserService _userServ;
    private readonly INotificationService _service;
    private readonly ILogger<NotificationController> _logger;
    public NotificationController(INotificationService service, ILogger<NotificationController> logger, IUserService userServ)
    {
      _service = service;
      _logger = logger;
      _userServ = userServ;
    }

    [HttpPost]
    public async Task<ActionResult> CreateNotification([FromBody] NotificationToCreateDto create)
    {
      try
      {

        if(await _userServ.UserExist(create.UserId)) 
          return BadRequest("No existe el usuario");

        var response =  await _service.Create(create);

        if(response == null)
          return BadRequest("No se pudo crear");
        
        return Ok(response);
      }
      catch(Exception err)
      {
        _logger.LogError(err.Message);
        Console.WriteLine(err.StackTrace);
        return BadRequest(message_error);
      }
    }
    
    [HttpGet("{user_id}")]
    public async Task<ActionResult> GetNotification(int user_id)
    {
      try
      {
        var response =  await _service.GetList(user_id);

        if(response.Count == 0)
          return Ok("No hay notificaciones");
          
        if(response == null)
          return BadRequest("Error al obtener notificaciones");
        
        return Ok(response);
      }
      catch(Exception err)
      {
        _logger.LogError(err.Message);
        Console.WriteLine(err.StackTrace);
        return BadRequest(message_error);
      }
    }

    [HttpPut]
    public async Task<IActionResult> UpdateNotification([FromBody]  NotificationToUpdateDto update)
    {
      try
      {
        var response =  await _service.Update(update);
          
        if(response == null)
          return BadRequest("Error al actualizar notificacion");
        
        return Ok(response);
      }
      catch(Exception err)
      {
        _logger.LogError(err.Message);
        Console.WriteLine(err.StackTrace);
        return BadRequest(message_error);
      }
    }
  }
}