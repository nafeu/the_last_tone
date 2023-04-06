import 'dart:math';
import 'package:the_last_tone/constants/globals.dart';

List<String> getRandomUniqueItems(List<String> inputList, int n) {
  final random = Random();
  final result = <String>[];

  if (n > inputList.length) {
    throw ArgumentError('n cannot be greater than the length of inputList');
  }

  while (result.length < n) {
    final randomIndex = random.nextInt(inputList.length);
    final randomItem = inputList[randomIndex];

    if (!result.contains(randomItem)) {
      result.add(randomItem);
    }
  }

  return result;
}

List<String> getNRandomNotes(int n) => getRandomUniqueItems(Globals.musicalNotes, n);

String getRandomLetter() {
  final random = Random();
  final charCode = random.nextInt(26) + 65; // ASCII code for 'A' is 65
  return String.fromCharCode(charCode);
}
