import 'package:flutter/material.dart';
import 'package:note/ThemeConfig/app_theme.dart';

import 'dark_theme_preference.dart';

class LanguageChangeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();

  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  Locale _currentLocale = const Locale("fa");
  Locale get currentLocale => _currentLocale;

  String _currentFont = "Iran";
  String get currentFont => _currentFont;

  Color _currentColor = AppTheme.yellow; //Colors.purpleAccent;
  Color get currentColor => _currentColor;

  void changeLocal(String _lacale, String _font) {
    _currentLocale = Locale(_lacale);
    _currentFont = _font;
    notifyListeners();
  }

  void changeColor(Color _color) {
    _currentColor = _color;
    notifyListeners();
  }

  void changeTheme(bool value){
      _darkTheme = value;
      darkThemePreference.setDarkTheme(value);
      notifyListeners();
  }
}