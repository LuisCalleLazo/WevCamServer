import face_recognition
import numpy as np

def obtener_embeddings(imagen_paths):
  """
  Carga imágenes desde las rutas dadas y obtiene los embeddings de los rostros en cada una.
  """
  embeddings = []
  etiquetas = []
  
  for path, etiqueta in imagen_paths:
    # Cargar imagen
    imagen = face_recognition.load_image_file(path)
    
    # Obtener embeddings de los rostros detectados
    encoding = face_recognition.face_encodings(imagen)
    
    if encoding:
      embeddings.append(encoding[0])  # Usar el primer rostro encontrado
      etiquetas.append(etiqueta)  # Etiqueta: 1 si es "Pepe", 0 si no lo es
  
  return np.array(embeddings), np.array(etiquetas)

# Definir rutas y etiquetas de imágenes de entrenamiento (1 para "Pepe", 0 para otros)
imagenes_entrenamiento = [
    ("person_image_demo/aurora1.jpg", 1),
    ("person_image_demo/aurora3.jpg", 1),
    ("person_image_demo/aurora4.jpg", 1),
    ("person_image_demo/aurora5.png", 1),
    ("person_image_demo/no_aurora1.jpg", 0),
    ("person_image_demo/no_aurora2.jpg", 0),
    ("person_image_demo/no_aurora3.jpg", 0),
    ("person_image_demo/no_aurora4.jpg", 0),
  # Agrega más imágenes según sea necesario
]

# Obtener embeddings y etiquetas
X_train, y_train = obtener_embeddings(imagenes_entrenamiento)
