import face_recognition
import sys

def detect_length_face(image_path):
    image = face_recognition.load_image_file(image_path)
    face_locations = face_recognition.face_locations(image)
    
    if face_locations:
        return len(face_locations)
    else:
        return 0

if __name__ == "__main__":
  image_path = sys.argv[1]
  print(detect_length_face(image_path))
