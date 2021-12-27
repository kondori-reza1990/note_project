import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:note/Database/hive_db.dart';
import 'package:note/Provider/dark_theme_preference.dart';
import 'package:note/Provider/dark_theme_styles.dart';
import 'package:note/Provider/language_change_provider.dart';
import 'package:note/generated/l10n.dart';
import 'package:provider/provider.dart';

import 'Screens/home_screen.dart';

HiveDataBase hiveDB = HiveDataBase();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  hiveDB.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => LanguageChangeProvider()),
        ChangeNotifierProvider(create: (BuildContext context) => HiveDataBase())
      ],
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: Provider.of<LanguageChangeProvider>(context, listen: true)
              .currentLocale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: S.delegate.supportedLocales,
          title: 'Notes',
          theme: Styles.themeData(
              Provider.of<LanguageChangeProvider>(context, listen: true)
                  .darkTheme,
              context),
          home: const Home(),
        ),
      ),
    );
  }
}
