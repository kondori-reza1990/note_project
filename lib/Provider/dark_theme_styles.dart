import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:note/ThemeConfig/app_theme.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.amber,
      primaryColor: isDarkTheme ? AppTheme.nearlyBlack : AppTheme.yellow,
      backgroundColor:
          isDarkTheme ? AppTheme.nearlyBlack : AppTheme.white,
      accentColor:
          isDarkTheme ? AppTheme.blackAccent : AppTheme.yellowAccent,
      accentIconTheme: isDarkTheme
          ? const IconThemeData(color: AppTheme.nearlyBlack)
          : const IconThemeData(color: AppTheme.white),
      indicatorColor:
          isDarkTheme ? AppTheme.nearlyBlack : AppTheme.white,
      buttonColor:
          isDarkTheme ? AppTheme.nearlyBlack : AppTheme.white,
      dividerColor: isDarkTheme ? AppTheme.blackAccent : AppTheme.white,
      fontFamily: 'Iran',
      hintColor:
          isDarkTheme ? AppTheme.nearlyBlack : AppTheme.pink,
      highlightColor:
          isDarkTheme ? AppTheme.nearlyBlack : AppTheme.yellow,
      hoverColor:
          isDarkTheme ? AppTheme.nearlyBlack : AppTheme.blue,
      focusColor:
          isDarkTheme ? AppTheme.nearlyBlack : AppTheme.green,
      disabledColor: Colors.grey,
      textSelectionColor: isDarkTheme ? AppTheme.white : AppTheme.nearlyBlack,
      cardColor: isDarkTheme ? AppTheme.nearlyBlack : AppTheme.white,
      canvasColor: isDarkTheme ? AppTheme.nearlyBlack : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
      ),
    );
  }
}
