import 'package:flutter/material.dart';
import '../colores.dart';

class QuestionCard extends StatelessWidget {
  final int number;
  final String text;

  const QuestionCard({super.key, required this.number, required this.text});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PREGUNTA $number',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: colorGris,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                text,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, height: 1.2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}