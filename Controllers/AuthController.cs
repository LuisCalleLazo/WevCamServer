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
  public class AuthController : ControllerBase
  {
    private readonly IAuthService _service;

    public AuthController(IAuthService service)
    {
      _service = service;
    }

  }
}