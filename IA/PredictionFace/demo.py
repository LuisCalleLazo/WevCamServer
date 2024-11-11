import face_recognition
import numpy as np
import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'

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
]

# Obtener embeddings y etiquetas
X_train, y_train = obtener_embeddings(imagenes_entrenamiento)

from keras._tf_keras.keras.models import Sequential
from keras._tf_keras.keras.layers import Dense
from keras._tf_keras.keras.optimizers import Adam

# Definir el modelo
modelo = Sequential([
    Dense(128, activation='relu', input_shape=(128,)),
    Dense(64, activation='relu'),
    Dense(1, activation='sigmoid')  # Salida binaria: 1 para "Person", 0 para otros
])

# Compilar el modelo
modelo.compile(optimizer=Adam(learning_rate=0.001), loss='binary_crossentropy', metrics=['accuracy'])

# Entrenar el modelo
modelo.fit(X_train, y_train, epochs=50, batch_size=4)


def predecir_si_es_pepe(modelo, imagen_paths):
    """
    Dada una lista de rutas de imágenes, predice si contienen a "Pepe".
    """
    print("EL MODELO ES:")
    print(modelo)
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
    "images_predict/adele_predict1.jpeg",
    "images_predict/adele_predict2.jpg",
    "images_predict/aurora_predict1.jpg",
    "images_predict/aurora_predict2.jpg",
]

# Predecir si "Pepe" aparece en cada imagen
resultados = predecir_si_es_pepe(modelo, imagenes_a_verificar)
for imagen, es_pepe in resultados.items():
    if es_pepe is None:
        print(f"No se detectó rostro en la imagen: {imagen}")
    elif es_pepe:
        print(f"Se detectó a 'Pepe' en la imagen: {imagen}")
    else:
        print(f"'Pepe' no aparece en la imagen: {imagen}")
