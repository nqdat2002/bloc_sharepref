
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static const String _keyIsLoggedIn = 'is_logged_in';

  Future<bool> isLoggedIn() async {
    await Future.delayed(Duration(seconds: 1));
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  Future<void> logIn() async {
    await Future.delayed(Duration(seconds: 1));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, true);
  }

  Future<void> logOut() async {
    await Future.delayed(Duration(seconds: 1));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, false);
  }  

  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (username == 'admin' && password == '123456') {
      await logIn();
      return true;
    }
    return false;
  }

  Future<bool> signUp(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    await logIn();
    return true;
  }

}
