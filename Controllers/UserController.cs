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

  }
}