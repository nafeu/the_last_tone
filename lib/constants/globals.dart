class Globals {
  Globals._();

  static const String quackSound = 'quack.mp3';
  static const String oofSound = 'oof.mp3';

  static const List<String> musicalNotes = [
    'C',
    'C#',
    'D',
    'D#',
    'E',
    'F',
    'F#',
    'G',
    'G#',
    'A',
    'A#',
    'B',
  ];

  static const Map<String, String> pianoNoteMapping = {
    'C': 'piano_c.wav',
    'C#': 'piano_cs.wav',
    'D': 'piano_d.wav',
    'D#': 'piano_ds.wav',
    'E': 'piano_e.wav',
    'F': 'piano_f.wav',
    'F#': 'piano_fs.wav',
    'G': 'piano_g.wav',
    'G#': 'piano_gs.wav',
    'A': 'piano_a.wav',
    'A#': 'piano_as.wav',
    'B': 'piano_b.wav',
  };

  static List<String> pianoSounds = pianoNoteMapping.values.toList();
}
