import 'package:flutter/material.dart';
import '../colores.dart';
import '../datos_pokemon.dart';
import '../historial.dart';

class PantallaPokedex extends StatefulWidget {
  const PantallaPokedex({super.key});

  @override
  State<PantallaPokedex> createState() => _PantallaPokedexState();
}

class _PantallaPokedexState extends State<PantallaPokedex> {
  String filtro = 'Todos';

  void mostrarResumen(String nombre, int id) {
    final cantidad = Historial.veces[id];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(nombre),
          content: Text('Te ha salido $cantidad vez/veces.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  Widget circuloPokemon(bool desbloqueado, int id, String emocion) {
    if (desbloqueado) {
      final Color color = colorDeEmocion[emocion]!;
      return Container(
        width: 58,
        height: 58,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: color.withAlpha(110), blurRadius: 10)],
        ),
        child: Image.network(
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
        ),
      );
    }

    return Container(
      width: 58,
      height: 58,
      decoration: const BoxDecoration(
        color: Color(0xFFC8C8C8),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Text('?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtros = ['Todos', ...listaEmociones];

    final visibles = listaPokemon.where((p) {
      return filtro == 'Todos' || p['emocion'] == filtro;
    }).toList();

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Row(
            children: filtros.map((nombreFiltro) {
              final bool activo = filtro == nombreFiltro;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(nombreFiltro),
                  selected: activo,
                  showCheckmark: false,
                  selectedColor: colorAzul,
                  backgroundColor: Colors.white,
                  elevation: 1,
                  shape: const StadiumBorder(side: BorderSide.none),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: activo ? Colors.white : Colors.black,
                  ),
                  onSelected: (valor) {
                    setState(() {
                      filtro = nombreFiltro;
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),

        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.95,
            ),
            itemCount: visibles.length,
            itemBuilder: (context, indice) {
              final pokemon = visibles[indice];
              final int id = pokemon['id'];
              final String nombre = pokemon['nombre'];
              final String emocion = pokemon['emocion'];
              final bool desbloqueado = Historial.veces.containsKey(id);

              return GestureDetector(
                onTap: () {
                  if (desbloqueado) {
                    mostrarResumen(nombre, id);
                  }
                },
                child: Card(
                  margin: EdgeInsets.zero,
                  color: Colors.white,
                  elevation: 2,
                  shadowColor: const Color(0x22000000),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      circuloPokemon(desbloqueado, id, emocion),
                      const SizedBox(height: 8),
                      Text(
                        desbloqueado ? nombre : 'Bloqueado',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}