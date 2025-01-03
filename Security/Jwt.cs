
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using Microsoft.IdentityModel.Tokens;
using WebCamServer.Dtos;
using WebCamServer.Models;

namespace WebCamServer.Security
{
  public class Jwt
  {

    public static string GenerateToken(
      AuthJwtDto jwt, User user)
    {
      var tokenHandler = new JwtSecurityTokenHandler();

      var claimbs = new List<Claim>
      {
        new Claim(JwtRegisteredClaimNames.Sub, jwt.Subject),
        new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
        new Claim(JwtRegisteredClaimNames.Iat, DateTime.UtcNow.ToString()),
        
        new Claim("id", user.Id.ToString()),
        new Claim("name", user.Name),
      };

      var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwt.Key));
      var Sigin = new SigningCredentials(key, SecurityAlgorithms.HmacSha256Signature);

      var tokenDesc = new SecurityTokenDescriptor
      {
        Subject = new ClaimsIdentity(claimbs),
        Expires = DateTime.UtcNow.AddMinutes(jwt.TimeValidMin),
        Issuer = jwt.Issuer,
        Audience = jwt.Audience,
        SigningCredentials = Sigin
      };

      var token = tokenHandler.CreateToken(tokenDesc);
      var jwt_token = tokenHandler.WriteToken(token);

      return jwt_token;
    }
    
    public static string GenerateRefreshToken() {

      var byteArray = new byte[64];
      var refreshToken = "";

      using (var rng = RandomNumberGenerator.Create()) {
        rng.GetBytes(byteArray);
        refreshToken = Convert.ToBase64String(byteArray);
      } 

      return refreshToken;
    }
    public static int ValidateAndGetUserIdFromToken(string token, AuthJwtDto jwt)
    {
      try
      {
        var tokenHandler = new JwtSecurityTokenHandler();
        var key = Encoding.UTF8.GetBytes(jwt.Key);

        var validationParameters = new TokenValidationParameters
        {
          ValidateIssuerSigningKey = true,
          IssuerSigningKey = new SymmetricSecurityKey(key),
          ValidateIssuer = false,
          ValidateAudience = false,
          ClockSkew = TimeSpan.Zero
        };

        var principal = tokenHandler.ValidateToken(token, validationParameters, out SecurityToken validatedToken);
        var jwtToken = (JwtSecurityToken)validatedToken;

        var userIdClaim = jwtToken.Claims.FirstOrDefault(x => x.Type == "id");
        return userIdClaim != null ? int.Parse(userIdClaim.Value) : 0;
      }
      catch
      {
        Console.WriteLine("ALGO SALIO MAL");
        // Retornar null si el token no es válido
        return 0;
      }
    }
  }
}