import 'dart:math';

class TokenGenerator{
  final Random _random = Random();

  String generateToken() {
    // Generate a random number between 1000000 and 9999999
    final randomNumber = _random.nextInt(9000000) + 10000000;
    // Get the current timestamp in milliseconds
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    // Combine the timestamp and random number, then take the last 7 digits
    final token = (timestamp + randomNumber).toString().substring(0, 7);
    return token;
  }

}
