namespace WebCamServer.Helpers
{
  public static class ValidateFile
  {
    public static bool IsImageFormatValid(IFormFile image)
    {
      // Verifica la extensión
      var validExtensions = new[] { ".jpg", ".jpeg", ".png" };
      var fileExtension = Path.GetExtension(image.FileName).ToLower();

      if (!validExtensions.Contains(fileExtension))
        return false;

      // Verifica el tipo de contenido
      var validContentTypes = new[] { "image/jpeg", "image/png" };

      if (!validContentTypes.Contains(image.ContentType.ToLower())) 
        return false;

      return true;
    }
  }
}