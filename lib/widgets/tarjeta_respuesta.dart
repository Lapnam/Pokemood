import 'package:flutter/material.dart';
import '../colores.dart';

class AnswerCard extends StatelessWidget {
  final String letter;
  final Color color;
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const AnswerCard({
    super.key,
    required this.letter,
    required this.color,
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? const Color(0xFFFFF6CC) : Colors.white,
      elevation: selected ? 4 : 2,
      shadowColor: selected ? colorAmarillo : const Color(0x33000000),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 64),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? colorAmarillo : Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: color,
                child: Text(
                  letter,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              if (selected) const Icon(Icons.check, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}