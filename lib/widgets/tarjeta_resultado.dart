import 'package:flutter/material.dart';
import '../colores.dart';

class ResultCard extends StatelessWidget {
  final String emotionText;
  final int id;
  final String name;
  final String type;
  final int hp;
  final int attack;
  final int speed;
  final bool loading;
  final bool hasError;
  final String description;

  const ResultCard({
    super.key,
    required this.emotionText,
    required this.id,
    required this.name,
    required this.type,
    required this.hp,
    required this.attack,
    required this.speed,
    required this.loading,
    required this.hasError,
    required this.description,
  });

  // Rounded label (emotion and type)
  Widget _chip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
    );
  }

  Widget _pokemonCircle() {
    return Container(
      width: 150,
      height: 150,
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: Alignment(-0.3, -0.4),
          colors: [Color(0xFFFBE86B), colorAmarillo, colorNaranja],
          stops: [0.0, 0.55, 1.0],
        ),
        boxShadow: [
          BoxShadow(color: Color(0x80F5C90F), blurRadius: 24, spreadRadius: 4),
        ],
      ),
      child: Image.network(
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const Center(
            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
          );
        },
        errorBuilder: (context, error, stack) {
          return const Icon(Icons.catching_pokemon, size: 60, color: Colors.white);
        },
      ),
    );
  }

  Widget _statRow(String label, int value) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: (value / 200).clamp(0.0, 1.0),
              minHeight: 10,
              color: colorAzul,
              backgroundColor: const Color(0xFFE4E8EF),
            ),
          ),
        ),
        SizedBox(
          width: 40,
          child: Text(
            '$value',
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _statsBlock() {
    if (loading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: CircularProgressIndicator(color: colorRojo),
      );
    }

    if (hasError) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text(
          'No se pudieron cargar los datos.\nRevisa tu conexión a internet.',
          textAlign: TextAlign.center,
        ),
      );
    }

    return Column(
      children: [
        _statRow('HP', hp),
        const SizedBox(height: 8),
        _statRow('Ataque', attack),
        const SizedBox(height: 8),
        _statRow('Velocidad', speed),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        elevation: 3,
        shadowColor: const Color(0x22000000),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _chip(emotionText, colorAmarillo),
              const SizedBox(height: 16),
              _pokemonCircle(),
              const SizedBox(height: 16),
              Text(name, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              if (type.isNotEmpty) _chip(type, colorNaranja),
              const SizedBox(height: 16),
              _statsBlock(),
              const SizedBox(height: 16),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}