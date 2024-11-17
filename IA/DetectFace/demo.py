import cv2
import dlib
import os

def detect_pose(image_path):

  try:

    # Archivo .Dat de face_landmarks 
    current_dir = os.path.dirname(os.path.abspath(__file__))
    dat_path = os.path.join(current_dir, "shape_predictor_68_face_landmarks.dat")

    # Carga del detector de puntos de referencia facial
    detector = dlib.get_frontal_face_detector()
    predictor = dlib.shape_predictor(dat_path)

    image = cv2.imread(image_path)
    if image is None:
        raise FileNotFoundError(f"No se pudo cargar la imagen desde la ruta: {image_path}")
    
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    faces = detector(gray)

    for face in faces:
        landmarks = predictor(gray, face)
        
        # Calcula los puntos clave para determinar la orientación
        nose = landmarks.part(30)
        left_eye = landmarks.part(43)
        right_eye = landmarks.part(40)

        range_eye_left = abs(nose.x - left_eye.x)
        range_eye_rigth = abs(nose.x - right_eye.x)

        promed = abs(range_eye_left - range_eye_rigth)
        constant = 30
        # Calcular la pose basándose en los landmarks
        if range_eye_left > range_eye_rigth and promed > constant:
            return "right"
        
        elif range_eye_left < range_eye_rigth and promed > constant:
            return "left"
        
        elif promed <= constant:
            return "front"
        
        else:
            return "front"

    return "unknown"
  
  except FileNotFoundError as fnf_error:
      print(f"Error: {fnf_error}")
  except dlib.error as dlib_error:
      print(f"Error al cargar el predictor o procesar la imagen: {dlib_error}")
  except Exception as e:
      print(f"Ocurrió un error inesperado: {e}")


current_dir = os.path.dirname(os.path.abspath(__file__))
print(detect_pose(os.path.join(current_dir, "front.jpg")))