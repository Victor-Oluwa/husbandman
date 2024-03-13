import 'dart:math';

class TokenGenerator{
  final Random _random = Random();

  String generateToken() {
    // Generate a random number between 1000000000 and 999999999
    final randomNumber = _random.nextInt(900000000) + 1000000000;
    // Get the current timestamp in milliseconds
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    // Combine the timestamp and random number, then take the last 11 digits
    final token = (timestamp + randomNumber).toString().substring(0, 11);
    return token;
  }
}
