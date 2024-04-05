import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs{
  late final SharedPreferences _sharedPreferences;

  Future<void> init()async{
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  SharedPreferences get prefs => _sharedPreferences;
}

final sharedPrefs = SharedPrefs();
