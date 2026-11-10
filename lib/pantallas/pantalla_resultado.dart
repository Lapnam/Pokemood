import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../colores.dart';
import '../logica_test.dart';
import '../widgets/tarjeta_consejo.dart';
import '../widgets/tarjeta_resultado.dart';

class ResultScreen extends StatefulWidget {
  final String emotion;
  final int id;
  final String name;

  const ResultScreen({
    super.key,
    required this.emotion,
    required this.id,
    required this.name,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  // PokeAPI data
  bool loading = true;
  bool hasError = false;
  String type = '';
  int hp = 0;
  int attack = 0;
  int speed = 0;

  bool adviceLoading = true;
  String advice = '';

  @override
  void initState() {
    super.initState();
    loadPokemon(); // API 1: PokeAPI
    loadAdvice(); // API 2: Advice Slip
  }

  // API 1: PokeAPI (type and stats)
  Future<void> loadPokemon() async {
    try {
      final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/${widget.id}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        type = capitalize(data['types'][0]['type']['name']);

        for (final stat in data['stats']) {
          final String statName = stat['stat']['name'];
          final int value = stat['base_stat'];
          if (statName == 'hp') {
            hp = value;
          } else if (statName == 'attack') {
            attack = value;
          } else if (statName == 'speed') {
            speed = value;
          }
        }
      } else {
        hasError = true;
      }
    } catch (e) {
      hasError = true;
    }

    if (!mounted) return;
    setState(() {
      loading = false;
    });
  }

  Future<void> loadAdvice() async {
    try {
      final url = Uri.parse('https://api.adviceslip.com/advice');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        advice = data['slip']['advice'];
      } else {
        advice = randomBackupAdvice();
      }
    } catch (e) {
      advice = randomBackupAdvice();
    }

    if (!mounted) return;
    setState(() {
      adviceLoading = false;
    });
  }

  Widget decorativeCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  AppBar buildTopBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 110,
      backgroundColor: colorRojo,
      foregroundColor: Colors.white,
      elevation: 8,
      shadowColor: const Color(0x66DC2535),
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      flexibleSpace: Stack(
        children: [
          Positioned(top: -50, right: -40, child: decorativeCircle(180, const Color(0x26FFFFFF))),
          Positioned(bottom: -45, right: 90, child: decorativeCircle(110, const Color(0xCCF58A27))),
        ],
      ),
      centerTitle: false,
      titleSpacing: 24,
      title: const Text(
        'Tu resultado',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const buttonShape = RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18)));
    const buttonText = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: buildTopBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ResultCard(
              emotionText: emotionLabel[widget.emotion] ?? widget.emotion,
              id: widget.id,
              name: widget.name,
              type: type,
              hp: hp,
              attack: attack,
              speed: speed,
              loading: loading,
              hasError: hasError,
              description: emotionDescription[widget.emotion] ?? '',
            ),
            const SizedBox(height: 20),

            AdviceCard(text: advice, loading: adviceLoading),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorRojo,
                        foregroundColor: Colors.white,
                        elevation: 3,
                        shape: buttonShape,
                      ),
                      onPressed: () => Navigator.pop(context, 'repeat'),
                      child: const Text('Repetir test', style: buttonText),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colorRojo,
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: colorRojo, width: 2),
                        shape: buttonShape,
                      ),
                      onPressed: () => Navigator.pop(context, 'pokedex'),
                      child: const Text('Ver Pokédex', style: buttonText),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}