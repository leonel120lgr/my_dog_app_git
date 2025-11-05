# my_dog_app_flutter

Instrucciones de uso del sistema (My Dog App)

Hola, les dejo un saludo y, a continuación, el uso del sistema.

Asegúrense de que su IDE o editor de código esté en la siguiente ruta:

~/my_dog_app_git/my_dog_app_flutter/

Nota importante: todo dispositivo físico que se use para compilar el proyecto debe tener activadas las opciones de desarrollador.

Versión de Flutter utilizada en este proyecto:
3.35.4

# Ejecutar proyecto en Visual Studio Code

1.- Tener encendido su emulador o dispositivo físico conectado a la PC donde va a correr el proyecto.
2.- Encontrar el archivo main.dart dentro de la carpeta lib.
3.- En la parte inferior derecha, asegurarse de que su teléfono o emulador sea reconocido por Visual Studio Code.
4.- Permaneciendo dentro del archivo main.dart, podrá ejecutar el proyecto con el botón en la parte superior derecha (▶️).

# Ejecutar proyecto en Android Studio

Versión de Android Studio utilizada:
Android Studio (2024.3)

1.- Abra Android Studio y seleccione el proyecto my_dog_app_flutter ubicado previamente.
2.- Conecte su dispositivo físico o encienda su emulador Android.
3.- Presione el botón Run (▶️), seleccionando el dispositivo donde desea correr su proyecto.

# Ejecutar proyecto en Xcode

Versión de macOS y Xcode:
Xcode - Develop for iOS and macOS (Xcode 26.0.1)

1.- Abra el proyecto en Xcode desde una terminal navegando a la siguiente ruta:

~/my_dog_app_git/my_dog_app_flutter/ios/

Luego ejecute el comando: open Runner.xcworkspace
2.- Con el proyecto abierto, seleccione su dispositivo iOS físico o emulador para correr el proyecto.
3.- Con el botón Run (▶️), compile el proyecto.

# Otras formas de compilar el proyecto

1- Ejecutar la app (usa lib/main.dart por defecto)
flutter run

2.- Para detener el proyecto CTRL + C

## Problemas comunes

- Errores de Gradle/AndroidX: `flutter clean && flutter pub get`.
- Problemas de CocoaPods (iOS): `cd ios && pod repo update && pod install`.
