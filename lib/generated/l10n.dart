// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `English`
  String get language {
    return Intl.message(
      'English',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get app_name {
    return Intl.message(
      'Notes',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Add new note`
  String get add_note {
    return Intl.message(
      'Add new note',
      name: 'add_note',
      desc: '',
      args: [],
    );
  }

  /// `Edit note`
  String get edit_note {
    return Intl.message(
      'Edit note',
      name: 'edit_note',
      desc: '',
      args: [],
    );
  }

  /// `Delete note`
  String get delete_note {
    return Intl.message(
      'Delete note',
      name: 'delete_note',
      desc: '',
      args: [],
    );
  }

  /// `Note's date`
  String get note_date {
    return Intl.message(
      'Note\'s date',
      name: 'note_date',
      desc: '',
      args: [],
    );
  }

  /// `Note's title`
  String get note_title {
    return Intl.message(
      'Note\'s title',
      name: 'note_title',
      desc: '',
      args: [],
    );
  }

  /// `Note's Content`
  String get note_content {
    return Intl.message(
      'Note\'s Content',
      name: 'note_content',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get dark_mode {
    return Intl.message(
      'Dark Mode',
      name: 'dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Light Mode`
  String get light_mode {
    return Intl.message(
      'Light Mode',
      name: 'light_mode',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get app_language {
    return Intl.message(
      'Language',
      name: 'app_language',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get about_title {
    return Intl.message(
      'About us',
      name: 'about_title',
      desc: '',
      args: [],
    );
  }

  /// `Developer:\nVida-Rayane.ir - 09304898743`
  String get about_text {
    return Intl.message(
      'Developer:\nVida-Rayane.ir - 09304898743',
      name: 'about_text',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok_dialog {
    return Intl.message(
      'OK',
      name: 'ok_dialog',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel_dialog {
    return Intl.message(
      'Cancel',
      name: 'cancel_dialog',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete the note?`
  String get delete_note_content {
    return Intl.message(
      'Are you sure you want to delete the note?',
      name: 'delete_note_content',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'fa'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
