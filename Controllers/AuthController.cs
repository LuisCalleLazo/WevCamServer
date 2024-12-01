
using System.IdentityModel.Tokens.Jwt;
using Microsoft.AspNetCore.Mvc;
using WebCamServer.Dtos;
using WebCamServer.Services.Interfaces;

namespace WebCamServer.Controllers
{
  [Route("api/v1/auth")]
  [ApiController]
  public class AuthController : ControllerBase
  {
    private string message_error = "Hubo un error, consulte con el administrador";
    private readonly IAuthService _service;
    private readonly ILogger<AuthController> _logger;
    private readonly IUserService _userServ;

    public AuthController(IAuthService service, ILogger<AuthController> logger, IUserService userServ)
    {
      _service = service;
      _logger = logger;
      _userServ = userServ;
    }

    [HttpPost("login")]
    public async Task<IActionResult> Login([FromBody] AuthLoginDto auth)
    {
      try
      {
        var response =  await _service.Login(auth);

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

    
    [HttpPost("register-user")]
    public async Task<IActionResult> RegisterUser([FromBody] UserToCreateDto create)
    {
      try
      {

        if(await _userServ.ExistName(create.Name))
          return BadRequest("El nombre ya esta registrado");
          
        if(await _userServ.ExistEmail(create.Email))
          return BadRequest("El email ya esta registrado");

        var response =  await _service.RegisterUser(create);
        
        return Ok(response);
      }
      catch(Exception err)
      {
        _logger.LogError(err.Message);
        Console.WriteLine(err.StackTrace);
        return BadRequest(message_error);
      }
    }
    
    [HttpPost("refresh-token")]
    public async Task<IActionResult> RefreshToken([FromBody] AuthRefreshTokenDto refresh)
    {
      try
      {
        var tokenHandler = new JwtSecurityTokenHandler();
        var tokenExpired = tokenHandler.ReadJwtToken(refresh.TokenExpired);

        if(tokenExpired.ValidTo > DateTime.UtcNow)
          return BadRequest("Token no ha expirado");

        int IdUser = Int32.Parse(tokenExpired.Claims.First(x => x.Type == "id").Value);

        if(!await _service.ValidateRefreshToken(refresh, IdUser))
          return BadRequest("El token y refresh token son invalidos");

        var authResponse = await _service.RefreshToken(IdUser);
        
        return Ok(authResponse);
        
      }catch(Exception err)
      {
        _logger.LogError(err.Message);
        Console.WriteLine(err.StackTrace);
        return BadRequest(message_error);
      }
    }

  }
}