class Historial {
  static int idDelDia = 0; 
  static int testsRealizados = 0;
  static String ultimoResultado = '-';

  static Map<int, int> veces = {};

  static Map<String, int> emociones = {};

  static int get desbloqueados => veces.length;

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