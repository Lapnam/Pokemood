import 'package:flutter/material.dart';
import 'colores.dart';
import 'historial.dart';
import 'pantalla_inicio.dart';
import 'pantalla_pokedex.dart';
import 'pantalla_perfil.dart';

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PokéMood',
      theme: ThemeData(
        scaffoldBackgroundColor: colorFondo,
        colorScheme: ColorScheme.fromSeed(seedColor: colorRojo),
        // Letra del diseño (si no quieres usar google_fonts, borra esta línea)
      ),
      home: const PantallaPrincipal(),
    );
  }
}

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  int _pestana = 0; // 0 = Inicio, 1 = Test, 2 = Pokédex, 3 = Perfil

  final List<String> _titulos = ['¿Qué Pokémon\neres?', 'Test', 'Mi Pokédex', 'Perfil'];

  void irAlTest() {
    setState(() {
      _pestana = 1;
    });
  }

  // Título del AppBar: en Inicio lleva el texto pequeño "POKÉMOOD" arriba
  Widget _construirTitulo() {
    if (_pestana == 0) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'POKÉMOOD',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            _titulos[0],
            style: const TextStyle(
              fontSize: 32,
              height: 1.1,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      );
    }
    return Text(
      _titulos[_pestana],
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  // Un circulo decorativo del encabezado
  Widget _circulo(double tamano, Color color) {
    return Container(
      width: tamano,
      height: tamano,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  // Cada botón de la barra de abajo. Cuando está activo se pinta la "pastilla" roja
  BottomNavigationBarItem _crearItem(IconData icono, String texto) {
    return BottomNavigationBarItem(
      label: texto,
      icon: _contenidoItem(icono, texto, false),
      activeIcon: _contenidoItem(icono, texto, true),
    );
  }

  Widget _contenidoItem(IconData icono, String texto, bool activo) {
    final Color colorContenido = activo ? Colors.white : Colors.black;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: activo ? colorRojo : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icono, size: 22, color: colorContenido),
          Text(
            texto,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: colorContenido),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pantallas = [
      PantallaInicio(irAlTest: irAlTest),
      const PantallaTestTemporal(), // <- aquí va la pantalla del Test de tu compañero
      const PantallaPokedex(),
      const PantallaPerfil(),
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _pestana == 0 ? 150 : 110,
        backgroundColor: colorRojo,
        foregroundColor: Colors.white,
        elevation: 8,
        shadowColor: const Color(0x66DC2535),
        clipBehavior: Clip.antiAlias,
        // Esquinas redondeadas abajo
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
        ),
        // Círculos decorativos de fondo
        flexibleSpace: Stack(
          children: [
            Positioned(top: -50, right: -40, child: _circulo(180, const Color(0x26FFFFFF))),
            Positioned(bottom: -45, right: 90, child: _circulo(110, const Color(0xCCF58A27))),
          ],
        ),
        centerTitle: false,
        titleSpacing: 24,
        title: _construirTitulo(),
        // El contador "5/30" solo se ve en la Pokédex
        actions: [
          if (_pestana == 2)
            Container(
              margin: const EdgeInsets.only(right: 24),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${Historial.desbloqueados}/30',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
        ],
      ),
      body: pantallas[_pestana],
      // Barra de abajo flotante, blanca y redondeada
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: const [
              BoxShadow(color: Color(0x22000000), blurRadius: 14, offset: Offset(0, 4)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: BottomNavigationBar(
              currentIndex: _pestana,
              onTap: (indice) {
                setState(() {
                  _pestana = indice;
                });
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: [
                _crearItem(Icons.home_outlined, 'Inicio'),
                _crearItem(Icons.checklist, 'Test'),
                _crearItem(Icons.grid_view_rounded, 'Pokédex'),
                _crearItem(Icons.person_outline, 'Perfil'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Pantalla de relleno para que la app corra mientras llega el Test real
class PantallaTestTemporal extends StatelessWidget {
  const PantallaTestTemporal({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Aquí va la pantalla del Test'));
  }
}