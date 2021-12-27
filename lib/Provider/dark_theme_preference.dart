import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreference {
  static const THEME_STATUS = "THEMESTATUS";
  static const INIT_SCREEN = "INITTSCREEN";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }

  setInitScreen(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(INIT_SCREEN, value);
  }

  Future<bool> getInitScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(INIT_SCREEN) ?? false;
  }
}
