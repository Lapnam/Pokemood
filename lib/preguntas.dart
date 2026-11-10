
class Answer {
  final String text;
  final String emotion;
  const Answer(this.text, this.emotion);
}

class Question {
  final String text;
  final List<Answer> answers;
  const Question(this.text, this.answers);
}

const List<Question> questionList = [
  Question('Un amigo te cancela a último momento. ¿Qué haces?', [
    Answer('Me molesto', 'Bravo'),
    Answer('Armo otro plan con otro amigo', 'Feliz'),
    Answer('Me preocupo de haber hecho algo', 'Ansioso'),
    Answer('Aprovecho para dormir', 'Tranquilo'),
  ]),
  Question('¿Cuál es tu fin de semana ideal?', [
    Answer('Una aventura improvisada', 'Valiente'),
    Answer('Una siesta larga y una película', 'Tranquilo'),
    Answer('Una fiesta con mucha gente', 'Feliz'),
    Answer('Hacerle bromas a alguien', 'Travieso'),
  ]),
  Question('Mañana tienes un examen. ¿Cómo te sientes?', [
    Answer('Estudio con toda la energía', 'Bravo'),
    Answer('Entro en pánico', 'Ansioso'),
    Answer('Lo enfrento sin miedo', 'Valiente'),
    Answer('Ya veré qué pasa', 'Tranquilo'),
  ]),
  Question('Llegas a una fiesta donde no conoces a nadie.', [
    Answer('Me presento con todos', 'Feliz'),
    Answer('Me quedo cerca de la salida, con nervios', 'Ansioso'),
    Answer('Busco a quién gastarle una broma', 'Travieso'),
    Answer('Me siento y observo con calma', 'Tranquilo'),
  ]),
  Question('Alguien te reta a una competencia.', [
    Answer('Acepto de inmediato', 'Valiente'),
    Answer('Me pongo serio y voy por todo', 'Bravo'),
    Answer('Dudo y le doy mil vueltas', 'Ansioso'),
    Answer('Preparo un truco para ganar', 'Travieso'),
  ]),
  Question('Tu mejor día empieza con...', [
    Answer('Música a todo volumen', 'Feliz'),
    Answer('Silencio y un desayuno tranquilo', 'Tranquilo'),
    Answer('Un plan secreto en mente', 'Travieso'),
    Answer('Ejercicio o algo intenso', 'Bravo'),
  ]),
  Question('Algo sale mal en tu trabajo o estudio.', [
    Answer('Lo resuelvo rápido, sin pensar mucho', 'Valiente'),
    Answer('Me da vueltas en la cabeza toda la noche', 'Ansioso'),
    Answer('Respiro hondo y sigo', 'Tranquilo'),
    Answer('Me río del asunto', 'Feliz'),
  ]),
  Question('Un amigo te pide un favor extraño.', [
    Answer('Lo hago, suena divertido', 'Travieso'),
    Answer('Lo hago sin dudar', 'Valiente'),
    Answer('Pregunto mil cosas antes', 'Ansioso'),
    Answer('Me quejo, pero ayudo', 'Bravo'),
  ]),
];