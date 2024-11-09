using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WebCamServer.Dtos;
using WebCamServer.Helpers;
using WebCamServer.Services.Interfaces;
//using WebCamServer.Models;

namespace WebCamServer.Controllers
{
  [Authorize]
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
    public async Task<ActionResult> UploadImagesMissing(MissingPhotosType type, [FromForm] MissingToPhotosDto missingData)
    {
      var user_id = User.FindFirst("id")?.Value;
      if(user_id == null) Unauthorized("El usuario no es reconocido");
      var userId = Int32.Parse(user_id);
      Console.WriteLine(user_id);
      try
      {
        var photos = missingData.Photos;

        // if( !(photos.Length >= 0 && photos.Length <5) ) 
        //   return BadRequest("Tiene que ver al menos 5 fotos");

        // if( photos.Length > 15 )
        //   return BadRequest("Son demasiadas archivos, maximo 15");

        for (int i = 0; i < photos.Length; i++)
        {
          if(!ValidateFile.IsImageFormatValid(photos[i])) 
            return BadRequest("Una imagen no tiene el formato correcto");
        }

        var saved = await _service.SavePhotosMissing(type, missingData, userId);
        if(!saved) 
          return BadRequest("No se pudo guardar bien las imagenes");

        var validate = _service.ValidatePhotos(type, userId, missingData.MissingId);
        if(!validate)
        {
          var removed = _service.RemovePhotosError(userId, missingData.MissingId);
          if(!removed) return BadRequest("Hubo un error con sus fotografias al ser guardadas");

          return BadRequest("Al menos 1 foto no es de rostro de la persona");
        } 

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