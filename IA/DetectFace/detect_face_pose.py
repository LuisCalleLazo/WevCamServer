import sys
import cv2
import dlib

def detect_pose(image_path):
  # Carga del detector de puntos de referencia facial
  detector = dlib.get_frontal_face_detector()
  predictor = dlib.shape_predictor("shape_predictor_68_face_landmarks.dat")
  
  image = cv2.imread(image_path)
  gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
  faces = detector(gray)

  for face in faces:
      landmarks = predictor(gray, face)
      
      # Calcula los puntos clave para determinar la orientación
      nose = landmarks.part(30)
      left_eye = landmarks.part(36)
      right_eye = landmarks.part(45)
      
      # Calcular la pose basándose en los landmarks
      if nose.x < left_eye.x:
          return "right"
      elif nose.x > right_eye.x:
          return "left"
      else:
          return "front"
  
  return "unknown"

# Recibe la ruta de la imagen desde la línea de comandos
if __name__ == "__main__":
  image_path = sys.argv[1]
  print(detect_pose(image_path))
