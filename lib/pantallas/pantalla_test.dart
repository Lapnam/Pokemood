import 'package:flutter/material.dart';
import '../colores.dart';
import '../historial.dart';
import '../logica_test.dart';
import '../pantallas/pantalla_resultado.dart';
import '../preguntas.dart';
import '../widgets/tarjeta_pregunta.dart';
import '../widgets/tarjeta_respuesta.dart';

class TestScreen extends StatefulWidget {
  final VoidCallback goToPokedex;

  const TestScreen({super.key, required this.goToPokedex});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late List<Question> questions;
  late List<int?> chosen; 
  int current = 0;

  final List<String> letters = ['A', 'B', 'C', 'D'];
  final List<Color> letterColors = [colorRojo, colorAzul, colorVerde, colorNaranja];

  @override
  void initState() {
    super.initState();
    prepare();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentQuestion.value = 0;
    });
  }

  void prepare() {
    questions = shuffleQuestions();
    chosen = List<int?>.filled(totalQuestions, null);
    current = 0;
  }

  void choose(int position) {
    setState(() {
      chosen[current] = position;
    });
  }

  void previous() {
    if (current == 0) return;
    setState(() {
      current = current - 1;
    });
    currentQuestion.value = current;
  }

  void next() {
    if (chosen[current] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Elige una respuesta primero')),
      );
      return;
    }

    if (current < totalQuestions - 1) {
      setState(() {
        current = current + 1;
      });
      currentQuestion.value = current;
    } else {
      finish();
    }
  }

  Future<void> finish() async {
    final List<String> emotions = [];
    for (int i = 0; i < questions.length; i++) {
      emotions.add(questions[i].answers[chosen[i]!].emotion);
    }

    final String winner = calculateEmotion(emotions);
    final Map<String, dynamic> pokemon = drawPokemon(winner);
    final int id = pokemon['id'];
    final String name = pokemon['nombre'];

    Historial.registrar(id, name, winner);

    final String? action = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(emotion: winner, id: id, name: name),
      ),
    );

    if (!mounted) return;
    setState(() {
      prepare();
    });
    currentQuestion.value = 0;

    if (action == 'pokedex') {
      widget.goToPokedex();
    }
  }

  Widget arrowButton(IconData icon, VoidCallback? onPressed) {
    return SizedBox(
      width: 52,
      height: 46,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorRojo,
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0x59DC2535),
          disabledForegroundColor: Colors.white,
          padding: EdgeInsets.zero,
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: onPressed,
        child: Icon(icon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[current];
    final bool hasAnswer = chosen[current] != null;
    final bool isLast = current == totalQuestions - 1;

    String hint = 'Elige una opción para continuar';
    if (hasAnswer) {
      hint = isLast ? 'Pulsa la flecha para ver tu resultado' : 'Pulsa la flecha para continuar';
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          QuestionCard(number: current + 1, text: question.text),
          const SizedBox(height: 16),

          for (int i = 0; i < question.answers.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: AnswerCard(
                letter: letters[i],
                color: letterColors[i],
                text: question.answers[i].text,
                selected: chosen[current] == i,
                onTap: () => choose(i),
              ),
            ),

          // Arrows
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              arrowButton(Icons.arrow_back, current > 0 ? previous : null),
              const SizedBox(width: 28),
              arrowButton(Icons.arrow_forward, next),
            ],
          ),
          const SizedBox(height: 16),
          Text(hint, style: const TextStyle(fontSize: 14, color: colorGris)),
          const SizedBox(height: 90), // space for the floating bottom bar
        ],
      ),
    );
  }
}