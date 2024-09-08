using WebCamServer.Models;

namespace WebCamServer.Dtos
{
  
  public class UserToRegisterDto
  {
    public string Name {get; set;} 
    public string Email { get; set; }
    public string Password { get; set; } 
    public Guid PasswordSalt { get; set; }
    public string FirstName {get; set;} 
    public string MomLastName {get; set;} 
    public string DadLastName {get; set;} 
    public int Age {get; set;}
    public string City {get; set;}
    public DateTime CreateDate {get; set; }

    public UserToRegisterDto()
    {
      CreateDate = DateTime.UtcNow;
    }
  }

  public class UserToCreateDto
  {
    public string Name {get; set;} 
    public string Email { get; set; }
    public string Password { get; set; } 
    public string FirstName {get; set;} 
    public string MomLastName {get; set;} 
    public string DadLastName {get; set;} 
    public int Age {get; set;}
    public string City {get; set;} 
    public string Ci {get; set;} 
    public string GoogleId { get; set; } 
    public string FacebookId { get; set; } 
    public string TwitterId { get; set; } 
  }
  public class AuthRequestDto
  {
    public string NameOrGmail {get; set;} 
    public string Password {get; set;} 
  }
  public class AuthGoogleRequestDto
  {
    public string GoogleId {get; set;} 
  }
  public class AuthJwtDto
  {
    public string Key { get; set; } 
    public string Issuer { get; set; } 
    public string Audience { get; set; } 
    public string Subject { get; set; } 
    public int TimeValidMin {get; set;}
  }
  public class AuthRefreshTokenRequestDto
  {
    public string TokenExpired {get; set;} 
    public string RefreshToken {get; set;} 
  }
  public class AuthResponseDto
  {
    public User User {get; set;}
    public string CurrentToken {get; set;}
    public string RefreshToken {get; set;}
  }
}