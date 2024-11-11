
import face_recognition
import numpy as np
import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'
def predecir_si_es_pepe(modelo, imagen_paths):
    """
    Dada una lista de rutas de imágenes, predice si contienen a "Pepe".
    """
    resultados = {}
    
    for path in imagen_paths:
        imagen = face_recognition.load_image_file(path)
        encoding = face_recognition.face_encodings(imagen)
        
        if encoding:
            prediction = modelo.predict(np.array([encoding[0]]))
            es_pepe = prediction[0][0] > 0.5  # Umbral: si > 0.5, es "Pepe"
            resultados[path] = es_pepe
        else:
            resultados[path] = None  # No se detectó rostro en la imagen
    
    return resultados

# Lista de nuevas imágenes para verificar
imagenes_a_verificar = [
    "images_predict/aurora_predict2.jpg",
]

from keras._tf_keras.keras.models import load_model

modelo = load_model("modelo_aurora.keras")
# Predecir si "Aurora" aparece en cada imagen
resultados = predecir_si_es_pepe(modelo, imagenes_a_verificar)
for imagen, es_pepe in resultados.items():
    if es_pepe is None:
        print(f"No se detectó rostro en la imagen: {imagen}")
    elif es_pepe:
        print(f"Se detectó a 'Aurora' en la imagen: {imagen}")
    else:
        print(f"'Aurora' no aparece en la imagen: {imagen}")
