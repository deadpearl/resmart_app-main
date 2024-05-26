import 'package:shared_preferences/shared_preferences.dart';

class UserProvider {

  final tokenKey = "auth_token";
  final cityKey = "city";

  static const defaultCity = "Астана";

  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getString(tokenKey);
    } on Exception catch(_) {
      return null;
    }
  }

  Future<dynamic> setAuthToken(String? token) async {
    final prefs = await SharedPreferences.getInstance();
    if (token != null) {
      await prefs.setString(tokenKey, token);
    } else {
      await prefs.remove(tokenKey);
    }
  }

  Future<String> getSelectedCity() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getString(cityKey) ?? defaultCity;
    } on Exception catch(_) {
      return defaultCity;
    }
  }

  Future<dynamic> setSelectedCity(String? city) async {
    final prefs = await SharedPreferences.getInstance();
    if (city != null) {
      await prefs.setString(cityKey, city);
    } else {
      await prefs.remove(cityKey);
    }
  }

}