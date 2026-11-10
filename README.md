# Pokemood – ¿Qué Pokémon eres?

## Descripción

Pokemood es una aplicación móvil desarrollada en Flutter que permite descubrir qué Pokémon representa tu personalidad mediante un test de 8 preguntas.

Cada respuesta está asociada a una emoción. Al finalizar el test, se calcula la emoción predominante y se selecciona aleatoriamente uno de los cinco Pokémon asociados a ella.

La aplicación utiliza APIs externas para consultar información de los Pokémon y obtener consejos aleatorios.

## Funcionalidades

- Test de personalidad de 8 preguntas.
- Preguntas y respuestas en orden aleatorio.
- Cálculo de la emoción predominante.
- Selección aleatoria de Pokémon según el resultado.
- Información y estadísticas de los Pokémon.
- Pokémon del día.
- Pokédex personal con 30 Pokémon desbloqueables.
- Filtros por emoción.
- Historial de resultados y estadísticas personales.
- Consejos aleatorios al finalizar el test.

## Emociones y Pokémon

La aplicación cuenta con seis categorías de emociones, cada una asociada a cinco Pokémon.

| Emoción | Pokémon |
|---|---|
| Bravo / Energético | Pikachu, Primeape, Arcanine, Machamp, Tauros |
| Feliz / Sociable | Jigglypuff, Clefairy, Eevee, Chansey, Togepi |
| Ansioso / Confundido | Psyduck, Magikarp, Cubone, Diglett, Rattata |
| Tranquilo / Relajado | Snorlax, Slowpoke, Lapras, Bulbasaur, Squirtle |
| Valiente / Impulsivo | Charmander, Growlithe, Rapidash, Farfetch’d, Dratini |
| Travieso / Misterioso | Gengar, Haunter, Gastly, Meowth, Zubat |

## Pantallas de la aplicación

### Inicio
Muestra el Pokémon del día y permite iniciar el test o seleccionar otro Pokémon aleatoriamente.

### Test
Presenta ocho preguntas con cuatro opciones de respuesta. Las preguntas y respuestas se muestran en orden aleatorio.

### Resultado
Muestra el Pokémon obtenido, sus tipos, estadísticas, descripción de la emoción predominante y un consejo aleatorio. También permite repetir el test o acceder a la Pokédex.

### Mi Pokédex
Permite visualizar los 30 Pokémon disponibles, consultar los desbloqueados y filtrar por emoción.

### Perfil
Muestra estadísticas del usuario, como la cantidad de tests realizados, la emoción más frecuente y el último resultado. También permite borrar el historial.

## APIs utilizadas

**PokéAPI**

Se utiliza para obtener información de los Pokémon, como nombres, imágenes oficiales, tipos y estadísticas.


**Advice Slip API**

Se utiliza para obtener consejos aleatorios que aparecen en la pantalla de resultados.


## Tecnologías

- Flutter
- Dart
- Material Design
- Git y GitHub
- PokéAPI
- Advice Slip API

## Instalación y ejecución

### Requisitos

- Flutter SDK
- Dart SDK
- Visual Studio Code o Android Studio
- Emulador Android o dispositivo físico

### Pasos

1. Clonar el repositorio:
git clone URL_DEL_REPOSITORIO

2. Ingresar a la carpeta del proyecto:
cd pokemood

3. Instalar las dependencias:
flutter pub get

4. Ejecutar la aplicación:
flutter run

Se requiere conexión a internet para consultar las APIs externas.
