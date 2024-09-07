using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WebCamServer.Models;
using WebCamServer.Services.Interfaces;

namespace WebCamServer.Controllers
{
  [Route("api/user")]
  [ApiController]
  public class UserController : ControllerBase
  {
    private readonly IAuthService _authService;

    public UserController(IAuthService authService)
    {
      _authService = authService;
    }

    [HttpGet("list")]
    public async Task<ActionResult> GetTModels()
    {
      return Ok(await _authService.GetAllEntitiesAsync());
    }

    [HttpPost]
    public async Task<ActionResult> GetTModels(User user)
    {
      await _authService.CreateEntityAsync(user);
      return Ok("Se creo automaticamente");
    }
  }
}