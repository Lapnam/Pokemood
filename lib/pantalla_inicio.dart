import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'colores.dart';
import 'datos_pokemon.dart';
import 'historial.dart';

class PantallaInicio extends StatefulWidget {
  // Función que cambia a la pestaña del Test (viene del main)
  final VoidCallback irAlTest;

  const PantallaInicio({super.key, required this.irAlTest});

  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  String nombre = '';
  String tipo = '';
  bool cargando = true;
  bool hayError = false;

  @override
  void initState() {
    super.initState();
    if (Historial.idDelDia == 0) {
      sortearPokemon();
    }
    cargarPokemon();
  }

  void sortearPokemon() {
    final azar = Random();
    final pokemon = listaPokemon[azar.nextInt(listaPokemon.length)];
    Historial.idDelDia = pokemon['id'];
  }

  // Pone la primera letra en mayúscula
  String mayuscula(String texto) {
    return texto[0].toUpperCase() + texto.substring(1);
  }

  Future<void> cargarPokemon() async {
    setState(() {
      cargando = true;
      hayError = false;
    });

    try {
      final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/${Historial.idDelDia}');
      final respuesta = await http.get(url);

      if (respuesta.statusCode == 200) {
        final datos = jsonDecode(respuesta.body);
        nombre = mayuscula(datos['name']);
        tipo = mayuscula(datos['types'][0]['type']['name']);
      } else {
        hayError = true;
      }
    } catch (e) {
      hayError = true;
    }

    setState(() {
      cargando = false;
    });
  }

  // Etiqueta redondeada (la del tipo y la del número)
  Widget etiqueta(String texto, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        texto,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Tarjeta del Pokémon del día
          Card(
            color: Colors.white,
            elevation: 3,
            shadowColor: const Color(0x22000000),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                children: [
                  const Text(
                    'POKÉMON DEL DÍA',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: colorGris,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 260,
                    child: contenidoTarjeta(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),

          // Botón Empezar test
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorRojo,
                foregroundColor: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              ),
              onPressed: widget.irAlTest,
              child: const Text(
                'Empezar test',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            '8 preguntas para descubrirlo',
            style: TextStyle(fontSize: 13, color: colorGris),
          ),
        ],
      ),
    );
  }

  Widget contenidoTarjeta() {
    if (cargando) {
      return const Center(child: CircularProgressIndicator(color: colorRojo));
    }

    if (hayError) {
      return const Center(
        child: Text(
          'No se pudo cargar el Pokémon.\nRevisa tu conexión a internet.',
          textAlign: TextAlign.center,
        ),
      );
    }

    final id = Historial.idDelDia;
    return Column(
      children: [
        // Círculo amarillo con brillo detrás del Pokémon
        Container(
          width: 150,
          height: 150,
          padding: const EdgeInsets.all(14),
          decoration: const BoxDecoration(
            color: colorAmarillo,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Color(0x80F5C90F), blurRadius: 24, spreadRadius: 4),
            ],
          ),
          child: Image.network(
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
          ),
        ),
        const SizedBox(height: 16),
        Text(
          nombre,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            etiqueta(tipo, colorNaranja),
            const SizedBox(width: 8),
            etiqueta('#$id', const Color(0xFFD9D9D9)),
          ],
        ),
      ],
    );
  }
}