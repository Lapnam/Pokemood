// Guarda en memoria lo que le va pasando al usuario.
// Todo es "static" para poder usarlo desde cualquier pantalla sin complicarnos.
class Historial {
  static int idDelDia = 0; // 0 = todavía no se ha sorteado
  static int testsRealizados = 0;
  static String ultimoResultado = '-';

  // id del Pokémon -> cuántas veces te ha salido
  static Map<int, int> veces = {};

  // emoción -> cuántas veces ha ganado
  static Map<String, int> emociones = {};

  // Cuántos Pokémon distintos has desbloqueado (para "5/30")
  static int get desbloqueados => veces.length;

  // Emoción que más te ha salido
  static String get emocionFrecuente {
    if (emociones.isEmpty) return '-';
    String mejor = '';
    int max = 0;
    emociones.forEach((emocion, cantidad) {
      if (cantidad > max) {
        max = cantidad;
        mejor = emocion;
      }
    });
    return mejor;
  }

  // ESTA función la debe llamar la pantalla de Resultado
  // cuando el test termina. Ejemplo: Historial.registrar(143, 'Snorlax', 'Tranquilo');
  static void registrar(int id, String nombre, String emocion) {
    testsRealizados = testsRealizados + 1;
    ultimoResultado = nombre;
    veces[id] = (veces[id] ?? 0) + 1;
    emociones[emocion] = (emociones[emocion] ?? 0) + 1;
  }

  static void borrar() {
    testsRealizados = 0;
    ultimoResultado = '-';
    veces = {};
    emociones = {};
  }
}