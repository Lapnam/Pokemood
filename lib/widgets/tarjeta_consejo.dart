import 'package:flutter/material.dart';
import '../colores.dart';

class AdviceCard extends StatelessWidget {
  final String text;
  final bool loading;

  const AdviceCard({super.key, required this.text, required this.loading});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorAzul,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: Color(0x664A97C7), blurRadius: 16, offset: Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CONSEJO DE TU POKÉMON',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 0.5),
          ),
          const SizedBox(height: 10),
          if (loading)
            const LinearProgressIndicator(color: Colors.white, backgroundColor: Color(0x33FFFFFF))
          else
            Text(text, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, height: 1.3)),
        ],
      ),
    );
  }
}