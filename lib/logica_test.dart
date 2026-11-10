import 'dart:math';
import 'package:flutter/foundation.dart';
import 'datos_pokemon.dart';
import 'preguntas.dart';

const int totalQuestions = 8;

final ValueNotifier<int> currentQuestion = ValueNotifier<int>(0);

List<Question> shuffleQuestions() {
  final random = Random();
  final copy = List<Question>.from(questionList)..shuffle(random);
  return copy.take(totalQuestions).map((question) {
    final answers = List<Answer>.from(question.answers)..shuffle(random);
    return Question(question.text, answers);
  }).toList();
}

String calculateEmotion(List<String> chosenEmotions) {
  final Map<String, int> points = {};
  for (final emotion in chosenEmotions) {
    points[emotion] = (points[emotion] ?? 0) + 1;
  }

  int maxPoints = 0;
  points.forEach((emotion, amount) {
    if (amount > maxPoints) maxPoints = amount;
  });

  final tied = points.keys.where((e) => points[e] == maxPoints).toList();
  return tied[Random().nextInt(tied.length)];
}

// RANDOM 3: picks 1 of the 5 Pokémon of the winning emotion
Map<String, dynamic> drawPokemon(String emotion) {
  final candidates = listaPokemon.where((p) => p['emocion'] == emotion).toList();
  return candidates[Random().nextInt(candidates.length)];
}

String capitalize(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

const Map<String, String> emotionLabel = {
  'Bravo': 'Bravo/Energético',
  'Feliz': 'Feliz/Sociable',
  'Ansioso': 'Ansioso/Confundido',
  'Tranquilo': 'Tranquilo/Relajado',
  'Valiente': 'Valiente/Impulsivo',
  'Travieso': 'Travieso/Misterioso',
};

const Map<String, String> emotionDescription = {
  'Bravo':
      'Eres una persona intensa y llena de energía. Cuando algo te importa, lo defiendes con todo y nada te frena.',
  'Feliz':
      'Eres una persona alegre y sociable. Contagias buen ánimo y siempre encuentras motivos para sonreír.',
  'Ansioso':
      'Eres una persona sensible que piensa mucho las cosas. Tu mente va a mil, pero siempre encuentras cómo salir adelante.',
  'Tranquilo':
      'Eres una persona serena que enfrenta los imprevistos con calma y sabe disfrutar de su descanso.',
  'Valiente':
      'Eres una persona decidida que se lanza primero y piensa después. Los retos no te asustan, te motivan.',
  'Travieso':
      'Eres una persona ingeniosa y misteriosa, con un humor único. Te encanta sorprender y que nada sea aburrido.',
};

const List<String> backupAdvice = [
  'Respira hondo: casi todo se ve mejor después de un descanso.',
  'Un paso pequeño hoy vale más que un plan perfecto mañana.',
  'Está bien no tenerlo todo claro; sigue avanzando.',
  'Ríete de tus errores, también son parte del camino.',
  'Rodéate de quienes te hacen sentir tú.',
];

String randomBackupAdvice() {
  return backupAdvice[Random().nextInt(backupAdvice.length)];
}