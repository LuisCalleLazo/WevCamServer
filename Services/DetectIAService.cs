
using OpenCvSharp;
using OpenCvSharp.Dnn;
using WebCamServer.Repositories.Interfaces;
using WebCamServer.Services.Interfaces;
namespace WebCamServer.Services
{
  public class DetectIAService : IDetectIAService
  {
    private readonly IUserRepository _userRepo;
    public DetectIAService(IUserRepository userRepo)
    {
      _userRepo = userRepo;
    }


    public bool IsAuthorized(string capture)
    {
      // Cargar la base de datos de personas autorizadas
      Dictionary<string, Mat> authorizedPeople = LoadAuthorizedPeople();

      // Detectar el rostro en la imagen de entrada
      Mat imagen = new Mat(capture);
      Mat gris = new Mat();
      Cv2.CvtColor(imagen, gris, ColorConversionCodes.BGR2GRAY);
      CascadeClassifier clasificador = new CascadeClassifier("ruta/al/haarcascade_frontalface_default.xml");
      Rect[] rostros = clasificador.DetectMultiScale(gris);

      // Comparar el rostro detectado con los rostros en la base de datos
      foreach (Rect rostro in rostros)
      {
        Mat rostroImagen = new Mat(gris, rostro);
        foreach (KeyValuePair<string, Mat> authorizedPerson in authorizedPeople)
        {
          Mat authorizedFace = authorizedPerson.Value;
          double similarity = CalculateFaceSimilarity(rostroImagen, authorizedFace);
          if (similarity > 0.5) // Umbral de similitud
          {
            return true;
          }
        }
      }

      return false;
    }

    private Dictionary<string, Mat> LoadAuthorizedPeople()
    {
      return new Dictionary<string, Mat>();
    }

    private double CalculateFaceSimilarity(Mat face1, Mat face2)
    {
      return 0.0;
    }

    public bool HasHumanoidShape(string capture)
    {
      // Cargar la imagen de entrada
      Mat imagen = new Mat(capture);

      // Detectar objetos en la imagen utilizando YOLO o SSD
      Net net = CvDnn.ReadNetFromDarknet("ruta/al/yolov3.cfg", "ruta/al/yolov3.weights");
      Mat blob = CvDnn.BlobFromImage(imagen, 1 / 255.0, new Size(416, 416), new Scalar(0, 0, 0), true, false);
      net.SetInput(blob);
      Mat detection = net.Forward();

      // Buscar la detección de una persona en la imagen
      for (int i = 0; i < detection.Size(2); i++)
      {
        float confidence = detection.Get<float>(0, 0, i, 2);
        if (confidence > 0.5) // Umbral de confianza
        {
          int classId = (int)detection.Get<float>(0, 0, i, 1);
          if (classId == 0) // Clase "persona"
          {
            return true;
          }
        }
      }

      return false;
    }
  }
}