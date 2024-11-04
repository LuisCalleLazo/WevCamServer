using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WebCamServer.Dtos;
using WebCamServer.Helpers;
using WebCamServer.Services.Interfaces;
//using WebCamServer.Models;

namespace WebCamServer.Controllers
{
  [Route("api/v1/missing")]
  [ApiController]
  public class MissingController : ControllerBase
  {
    private string message_error = "Hubo un error, consulte con el administrador";
    private readonly IMissingService _service;
    private readonly ILogger<MissingController> _logger;
    public MissingController(IMissingService service, ILogger<MissingController> logger)
    {
      _service = service;
      _logger = logger;
    }

    [HttpPost]
    public async Task<ActionResult> RegisterMissing(MissingToCreateDto create)
    {
      try
      {
        var response =  await _service.RegisterMissing(create);

        if(response == null)
          return BadRequest("Credenciales incorrectas!!");
        
        return Ok(response);
      }
      catch(Exception err)
      {
        _logger.LogError(err.Message);
        Console.WriteLine(err.StackTrace);
        return BadRequest(message_error);
      }
    }

    [HttpPost("photos/{type}")]
    public async Task<ActionResult> UploadImagesMissing(MissingPhotosType type, [FromForm] IFormFile[] photos)
    {
    
      try
      {
        for (int i = 0; i < photos.Length; i++)
        {
          if(!ValidateFile.IsImageFormatValid(photos[i])) 
            return BadRequest("Una imagen no tiene el formato correcto");
        }
        var validate = await _service.ValidatePhotos(photos, type);
        
        if(!validate) BadRequest("Al menos 1 foto no es de rostro de la persona");

        return Ok("Se registro exitosamente");
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