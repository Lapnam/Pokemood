// Lista local con los 30 Pokémon (así la Pokédex no depende de internet)
const List<String> listaEmociones = [
  'Feliz',
  'Bravo',
  'Ansioso',
  'Tranquilo',
  'Valiente',
  'Travieso',
];

const List<Map<String, dynamic>> listaPokemon = [
  // Bravo
  {'id': 25, 'nombre': 'Pikachu', 'emocion': 'Bravo'},
  {'id': 57, 'nombre': 'Primeape', 'emocion': 'Bravo'},
  {'id': 59, 'nombre': 'Arcanine', 'emocion': 'Bravo'},
  {'id': 68, 'nombre': 'Machamp', 'emocion': 'Bravo'},
  {'id': 128, 'nombre': 'Tauros', 'emocion': 'Bravo'},
  // Feliz
  {'id': 39, 'nombre': 'Jigglypuff', 'emocion': 'Feliz'},
  {'id': 35, 'nombre': 'Clefairy', 'emocion': 'Feliz'},
  {'id': 133, 'nombre': 'Eevee', 'emocion': 'Feliz'},
  {'id': 113, 'nombre': 'Chansey', 'emocion': 'Feliz'},
  {'id': 175, 'nombre': 'Togepi', 'emocion': 'Feliz'},
  // Ansioso
  {'id': 54, 'nombre': 'Psyduck', 'emocion': 'Ansioso'},
  {'id': 129, 'nombre': 'Magikarp', 'emocion': 'Ansioso'},
  {'id': 104, 'nombre': 'Cubone', 'emocion': 'Ansioso'},
  {'id': 50, 'nombre': 'Diglett', 'emocion': 'Ansioso'},
  {'id': 19, 'nombre': 'Rattata', 'emocion': 'Ansioso'},
  // Tranquilo
  {'id': 143, 'nombre': 'Snorlax', 'emocion': 'Tranquilo'},
  {'id': 79, 'nombre': 'Slowpoke', 'emocion': 'Tranquilo'},
  {'id': 131, 'nombre': 'Lapras', 'emocion': 'Tranquilo'},
  {'id': 1, 'nombre': 'Bulbasaur', 'emocion': 'Tranquilo'},
  {'id': 7, 'nombre': 'Squirtle', 'emocion': 'Tranquilo'},
  // Valiente
  {'id': 4, 'nombre': 'Charmander', 'emocion': 'Valiente'},
  {'id': 58, 'nombre': 'Growlithe', 'emocion': 'Valiente'},
  {'id': 78, 'nombre': 'Rapidash', 'emocion': 'Valiente'},
  {'id': 83, 'nombre': "Farfetch'd", 'emocion': 'Valiente'},
  {'id': 147, 'nombre': 'Dratini', 'emocion': 'Valiente'},
  // Travieso
  {'id': 94, 'nombre': 'Gengar', 'emocion': 'Travieso'},
  {'id': 93, 'nombre': 'Haunter', 'emocion': 'Travieso'},
  {'id': 92, 'nombre': 'Gastly', 'emocion': 'Travieso'},
  {'id': 52, 'nombre': 'Meowth', 'emocion': 'Travieso'},
  {'id': 41, 'nombre': 'Zubat', 'emocion': 'Travieso'},
];