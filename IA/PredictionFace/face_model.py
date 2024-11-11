
from keras._tf_keras.keras.models import Sequential
from keras._tf_keras.keras.layers import Dense
from keras._tf_keras.keras.optimizers import Adam
from face_embeddings import X_train, y_train

# Definir el modelo
modelo = Sequential([
    Dense(128, activation='relu', input_shape=(128,)),
    Dense(64, activation='relu'),
    Dense(1, activation='sigmoid')  # Salida binaria: 1 para "Pepe", 0 para otros
])

# Compilar el modelo
modelo.compile(optimizer=Adam(learning_rate=0.001), loss='binary_crossentropy', metrics=['accuracy'])

# Entrenar el modelo
modelo.fit(X_train, y_train, epochs=50, batch_size=4)

modelo.save("modelo_aurora.keras")