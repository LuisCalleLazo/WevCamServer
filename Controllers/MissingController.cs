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
    private readonly IUserService _userServ;
    private readonly IMissingService _service;
    private readonly ILogger<MissingController> _logger;
    public MissingController(IMissingService service, ILogger<MissingController> logger, IUserService userServ)
    {
      _userServ = userServ;
      _service = service;
      _logger = logger;
    }

    [HttpPost]
    public async Task<ActionResult> RegisterMissing(MissingToCreateDto create)
    {
      try
      {
        var user_id = User.FindFirst("id")?.Value;
        if(user_id == null) Unauthorized("El usuario no es reconocido");
        int userId = Int32.Parse(user_id);

        var seeker = await _userServ.GetSeekerByUserId(userId);
        create.SeekerId = seeker.Id;
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
      int userId = Int32.Parse(user_id);
      
      try
      {
        // if(missingData.Photos.Length >= 0 && missingData.Photos.Length <3) 
        //   return BadRequest("Tiene que ver al menos 3 fotos");

        if( missingData.Photos.Length > 5 )
          return BadRequest("Son demasiadas archivos, maximo 5");

        foreach(var file in missingData.Photos)
        {
          if(!ValidateFile.IsImageFormatValid(file)) 
            return BadRequest("Una imagen no tiene el formato correcto");
        }

        var saved_temp = await _service.SavePhotosMissing(type, missingData, userId, true);
        if(!saved_temp) 
          return BadRequest("No se pudo guardar bien las imagenes");

        var validate = await _service.ValidatePhotos(type, userId, missingData.MissingId);
        var deleted = _service.RemovePhotosError(userId, missingData.MissingId, true);
        if(!validate)
          return BadRequest("Al menos 1 foto no es de rostro de la persona");
        
        var save = await _service.SavePhotosMissing(type, missingData, userId, false);
        if(!save) 
          return BadRequest("No se pudo guardar bien las imagenes");

        var updated = await _service.UpdatePhotosMissing(missingData.MissingId, type);

        if(!updated) return BadRequest("Se guardaron las fotos, pero no se actualizo el registro");

        if(await _service.GenerateModelNextToPhotos(userId, missingData.MissingId))
          Console.WriteLine("Se genero el modelo correctamente");

        return Ok("Se registro exitosamente");
      }
      catch(Exception err)
      {
        _logger.LogError(err.Message);
        Console.WriteLine(err.StackTrace);
        return BadRequest(message_error);
      }
    }
    
    [HttpGet]
    public async Task<IActionResult> GetMissingsOfSeeker()
    {
      try
      {
        var user_id = User.FindFirst("id")?.Value;
        if(user_id == null) Unauthorized("El usuario no es reconocido");
        int userId = Int32.Parse(user_id);

        var seeker = await _userServ.GetSeekerByUserId(userId);
        if(seeker == null) return BadRequest("No eres Seeker");
        
        var response =  await _service.GetListMissings(seeker.Id);

        if(response == null)
          return BadRequest("No existen datos");
        
        return Ok(response);
      }
      catch(Exception err)
      {
        _logger.LogError(err.Message);
        Console.WriteLine(err.StackTrace);
        return BadRequest(message_error);
      }
    }

    [HttpGet("{missing_id}/{type}")]
    public async Task<IActionResult> GetMissingsFilesZip(int missing_id, MissingPhotosType type)
    {
      try
      {
        var user_id = User.FindFirst("id")?.Value;
        if(user_id == null) Unauthorized("El usuario no es reconocido");
        int userId = Int32.Parse(user_id);
        
        var fileResults = new List<FileContentResult>();
        var response =  await _service.GetZipFilesMissing(userId, missing_id, type);

        if(response == null)
          return BadRequest("No existen las imagenes");
        
        return File(response, "application/zip", "files_missing.zip");
      }
      catch(Exception err)
      {
        _logger.LogError(err.Message);
        Console.WriteLine(err.StackTrace);
        return BadRequest(message_error);
      }
    }
    
    [HttpPut("{missingId}")]
    public async Task<ActionResult> UpdateMissing(int missingId, [FromBody] MissingToUpdateDto update)
    {
      try
      {
        var user_id = User.FindFirst("id")?.Value;
        if(user_id == null) Unauthorized("El usuario no es reconocido");
        int userId = Int32.Parse(user_id);

        var seeker = await _userServ.GetSeekerByUserId(userId);
        update.MissingId = missingId;
        update.SeekerId = seeker.Id;
        
        var response =  await _service.UpdateMissing(update);

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

    [HttpDelete("{missingId}")]
    public async Task<IActionResult> DeleteMissing(int missingId)
    {
      try
      {
        var user_id = User.FindFirst("id")?.Value;
        if(user_id == null) Unauthorized("El usuario no es reconocido");

        var response =  await _service.DeleteMissing(missingId);

        if(!response)
          return BadRequest("No se pudo eliminar");
        
        return Ok("Se elimino correctamente");
      }
      catch(Exception err)
      {
        _logger.LogError(err.Message);
        Console.WriteLine(err.StackTrace);
        return BadRequest(message_error);
      }
    }

    
    [HttpGet("single")]
    public async Task<IActionResult> GetMissingsSingleOfSeeker()
    {
      try
      {
        var user_id = User.FindFirst("id")?.Value;
        if(user_id == null) Unauthorized("El usuario no es reconocido");
        int userId = Int32.Parse(user_id);

        var seeker = await _userServ.GetSeekerByUserId(userId);
        if(seeker == null) return BadRequest("No eres Seeker");
        
        var response =  await _service.ListSingleMissing(seeker.Id);

        if(response == null)
          return BadRequest("No existen datos");
        
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