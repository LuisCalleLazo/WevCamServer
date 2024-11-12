import face_recognition
import numpy as np
from pathlib import Path
import os

os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'
def get_embeddings(imagen_paths):
  """
  Carga imágenes desde las rutas dadas y obtiene los embeddings de los rostros en cada una.
  """
  embeddings = []
  tags = []
  
  for path, etiqueta in imagen_paths:
    imagen = face_recognition.load_image_file(path)
    encoding = face_recognition.face_encodings(imagen)
    
    if encoding:
      embeddings.append(encoding[0])
      tags.append(etiqueta)
  
  return np.array(embeddings), np.array(tags)


def define_training_images(folder_training):
  folder = Path(folder_training)
  # Usamos glob para buscar archivos con extensiones específicas
  images = list(folder.glob("*.jpg")) + list(folder.glob("*.png")) + list(folder.glob("*.jpeg"))
  # Convertimos las rutas a cadenas de texto
  images = [str(imagen) for imagen in images]
  return images



def get_training_XY(folder_training : str):
  images_training = define_training_images(folder_training)
  X_train, y_train = get_embeddings(images_training)
  return X_train, y_train
