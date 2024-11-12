
from keras._tf_keras.keras.models import Sequential
from keras._tf_keras.keras.layers import Dense
from keras._tf_keras.keras.optimizers import Adam
from face_embeddings import get_training_XY
import os
import sys

def generate_model(name_model, type_save, training_model):
  try:
    path_model = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'Models')
    path_full = os.path.join(path_model, f"{name_model}.{type_save}")

    X_train, y_train = get_training_XY(training_model)

    # Definir el modelo
    model = Sequential([
      Dense(128, activation='relu', input_shape=(128,)),
      Dense(64, activation='relu'),
      Dense(1, activation='sigmoid')
    ])

    # Compilar el modelo
    model.compile(
      optimizer=Adam(learning_rate=0.001), 
      loss='binary_crossentropy', 
      metrics=['accuracy']
    )

    # Entrenar el modelo
    model.fit(X_train, y_train, epochs=50, batch_size=4)
    model.save(path_full)

    return True
  except Exception as e:
    return False


if __name__ == "__main__":
  name_model = sys.argv[1]
  type_save = sys.argv[2]
  folder_path = sys.argv[3]
  print(generate_model(name_model, type_save, folder_path))
