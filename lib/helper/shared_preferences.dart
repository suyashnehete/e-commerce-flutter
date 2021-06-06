import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  static Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  static Future<bool> isUserFirstTime() async {
    SharedPreferences prefs = await getSharedPreferences();
    return prefs.getBool("ISUSERFIRSTTIME") ?? true;
  }

  static Future<String> getAuthToken() async {
    SharedPreferences prefs = await getSharedPreferences();
    return prefs.getString("AUTHTOKEN") ?? null;
  }

  static void setUserFirstTime(bool isUserFirstTime) async {
    SharedPreferences prefs = await getSharedPreferences();
    prefs.setBool("ISUSERFIRSTTIME", isUserFirstTime);
  }

  static void setAuthToken(String token) async {
    SharedPreferences prefs = await getSharedPreferences();
    prefs.setString("AUTHTOKEN", token);
  }

  static void removeAuthToken() async {
    SharedPreferences prefs = await getSharedPreferences();
    prefs.clear();
  }
}
