import 'package:flutter/material.dart';
import '../colores.dart';
import '../historial.dart';

class PantallaPerfil extends StatefulWidget {
  const PantallaPerfil({super.key});

  @override
  State<PantallaPerfil> createState() => _PantallaPerfilState();
}

class _PantallaPerfilState extends State<PantallaPerfil> {

  Widget tarjetaDato(Color color, String titulo, String valor) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.all(6),
        color: Colors.white,
        elevation: 2,
        shadowColor: const Color(0x22000000),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(height: 10),
              Text(titulo, style: const TextStyle(fontSize: 12, color: colorGris)),
              const SizedBox(height: 4),
              Text(valor, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  void borrarHistorial() {
    setState(() {
      Historial.borrar();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Historial borrado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: colorAmarillo,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: const [
                BoxShadow(color: Color(0x33000000), blurRadius: 12, offset: Offset(0, 4)),
              ],
            ),

            child: ClipOval(
            child: Image.asset('assets/avatar.png',
              fit: BoxFit.cover,
            ),
          ),
          ),
          const SizedBox(height: 12),
          const Text('Ash.4k', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                tarjetaDato(colorRojo, 'Tests realizados', '${Historial.testsRealizados}'),
                tarjetaDato(colorVerde, 'Emoción más frecuente', Historial.emocionFrecuente),
              ],
            ),
          ),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                tarjetaDato(colorAzul, 'Desbloqueados', '${Historial.desbloqueados}/30'),
                tarjetaDato(colorNaranja, 'Último resultado', Historial.ultimoResultado),
              ],
            ),
          ),
          const SizedBox(height: 14),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: colorRojo,
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: colorRojo, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: borrarHistorial,
                child: const Text(
                  'Borrar historial',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}