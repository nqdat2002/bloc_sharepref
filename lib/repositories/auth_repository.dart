
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static const String _keyIsLoggedIn = 'is_logged_in';

  Future<bool> isLoggedIn() async {
    await Future.delayed(Duration(seconds: 1));
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }
}
