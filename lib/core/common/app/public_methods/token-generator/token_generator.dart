import 'dart:math';
import 'dart:developer' as dev;

class TokenGenerator{
  final Random _random = Random();

  String generateToken() {
    // Generate a random number between 1000000 and 9999999
    final randomNumber = _random.nextInt(9000000) + 10000000;
    // Get the current timestamp in milliseconds
    final timestamp = DateTime.now().millisecondsSinceEpoch;
dev.log(randomNumber.toString());
    return randomNumber.toString();
  }

}
