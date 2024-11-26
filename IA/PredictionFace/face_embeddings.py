import face_recognition
import numpy as np
from pathlib import Path
import os

os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'
path_current = os.path.dirname(os.path.abspath(__file__))

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


def define_training_images(folder_training, etiqueta):
  """
    Busca imágenes en la carpeta dada y asigna una etiqueta a cada imagen.

    :param folder_training: Ruta de la carpeta donde se encuentran las imágenes.
    :param etiqueta: Etiqueta que se asignará a las imágenes encontradas.
    :return: Lista de tuplas (ruta_imagen, etiqueta).
  """
  folder = Path(folder_training)
  images = list(folder.glob("*.jpg")) + list(folder.glob("*.png")) + list(folder.glob("*.jpeg"))
  images_with_labels = [(str(imagen), etiqueta) for imagen in images]
  return images_with_labels


def get_training_XY(folder_training : str):
  # Obtener imágenes positivas (etiqueta 1)
  images_positive = define_training_images(folder_training, 1)
  # Obtener imágenes negativas (etiqueta 0)
  images_negative = define_training_images(os.path.join(path_current, "negative_faces"), 0)
  # Combinar ambas listas
  all_images = images_positive + images_negative

  X_train, y_train = get_embeddings(all_images)
  return X_train, y_train
