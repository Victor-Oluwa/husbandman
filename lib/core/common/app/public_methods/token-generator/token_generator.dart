import 'dart:developer' as dev;
import 'dart:math';
import 'package:crypto/crypto.dart';

class TokenGenerator{
  String generateToken(List<int> tokensFromDatabase) {
    final generatedTokens = tokensFromDatabase.toSet();
    const min = 100000000000; // 12-digit minimum
    const max = 999999999999; // 12-digit maximum
    int randomNumber;

    do {
      final part1 = Random().nextInt(900000) + 100000; // 6 digits
      final part2 = Random().nextInt(900000) + 100000; // 6 digits
      randomNumber = part1 * 1000000 + part2;
    } while (generatedTokens.contains(randomNumber));
    generatedTokens.add(randomNumber);
    dev.log('Generated Tokens $generatedTokens');
    return randomNumber.toString();
  }

}
