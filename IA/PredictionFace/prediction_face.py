
from keras._tf_keras.keras.models import load_model
import face_recognition
import numpy as np
import os
import sys

os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'


def predict_face(model, image_path):
  
  """
  Dada una lista de rutas de imágenes, predice si contienen a "la cara de la persona del modelo".
  """

  result = ""
  image = face_recognition.load_image_file(image_path)
  encoding = face_recognition.face_encodings(image)
  
  if encoding:
    prediction = model.predict(np.array([encoding[0]]))
    is_face = prediction[0][0] > 0.5  # Umbral: si > 0.5, es Persona desaparecida
    result = is_face
  else:
    result = None

  return result

        
def predict_face_model(image_path, model_path):
  modelo = load_model(model_path)
  result = predict_face(modelo, image_path)

  if result is None: # No hay ningun rostro
      return 0
  elif result: # Se encontro el rostro
     return 1
  else:  # Hay rostro pero no es la persona que se busca
    return 2
  

if __name__ == "__main__":
  image_path = sys.argv[1]
  model_path = sys.argv[2]
  predict_face_model(image_path, model_path)