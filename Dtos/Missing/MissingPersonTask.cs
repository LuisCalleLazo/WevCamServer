namespace WebCamServer.Dtos
{
  public class MissingPersonTask
  {
    public string ImagesPath { get; set; }
    public string PathModel { get; set; }
    public int MatchCount { get; set; } 
    public bool IsResolved { get; set; }
    // Métodos adicionales pueden incluir lógica para marcar la tarea como resuelta, etc.
    public MissingPersonTask(string imagesPath, string pathModel)
    {
      ImagesPath = imagesPath;
      PathModel = pathModel;
      MatchCount = 0;
      IsResolved = false;
    }

    public void MarkAsFound()
    {
      MatchCount++;
      if (MatchCount >= 3) // O cualquier otro número que determines
      {
        IsResolved = true;
      }
    }
  }
}