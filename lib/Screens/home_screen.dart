import 'dart:async';

import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:note/CustomWidgets/CustomBottomBar/animated_bottom_navigation_bar.dart';
import 'package:note/Provider/dark_theme_preference.dart';
import 'package:note/Provider/language_change_provider.dart';
import 'package:note/Provider/permission_service.dart';
import 'package:note/Screens/new_note_screen.dart';
import 'package:note/ThemeConfig/app_theme.dart';
import 'package:note/generated/l10n.dart';
import 'package:provider/src/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  Flag country = Flag.fromCode(FlagsCode.IR);
  String countryName = "ایران";
  late AnimationController animationController;

  bool visible = true;
  late Timer _timer;
  int _start = 5;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            visible = false;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    PermissionService permissionService = PermissionService();
    permissionService.requestPermission();
    DarkThemePreference().getTheme().then(
        (value) => context.read<LanguageChangeProvider>().changeTheme(value));
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<LanguageChangeProvider>(context);
    int _bottomNavIndex = 0;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            appBar(themeProvider),
            /*SizedBox(
              width: 100,
              height: 100,
              child: Lottie.asset('assets/images/pin.json',
                  reverse: true, animate: true),
            ),*/
            Expanded(
                child: Center(
              child: Visibility(
                child: Text(
                  S.of(context).language,
                  style: TextStyle(
                      fontFamily:
                          context.read<LanguageChangeProvider>().currentFont),
                ),
                visible: visible,
              ),
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: themeProvider.darkTheme
            ? AppTheme.blackAccent
            : context.read<LanguageChangeProvider>().currentColor,
        tooltip: S.of(context).add_note,
        /*shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),*/
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const NewNote(flag: "add")));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: [
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8),
            child: SizedBox(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              //color: themeProvider.darkTheme ? themeProvider.darkBackgroundColor : themeProvider.lightBackgroundColor,
              child: Material(
                  color: Colors.transparent,
                  child: PopupMenuButton(
                      icon: Lottie.asset('assets/images/location.json',
                          reverse: true, animate: true), //country,
                      iconSize: 30,
                      itemBuilder: (_) => <PopupMenuItem<String>>[
                            PopupMenuItem<String>(
                                child: Row(
                                  children: [
                                    Flag.fromCode(
                                      FlagsCode.IR,
                                      height: 20,
                                      width: 50,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    const Text(
                                      'فارسی',
                                      style: TextStyle(fontFamily: 'Iran'),
                                    ),
                                  ],
                                ),
                                value: 'فارسی'),
                            PopupMenuItem<String>(
                                child: Row(
                                  children: [
                                    Flag.fromCode(
                                      FlagsCode.US,
                                      height: 20,
                                      width: 50,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    const Text(
                                      'English',
                                      style: TextStyle(fontFamily: 'English'),
                                    ),
                                  ],
                                ),
                                value: 'English'),
                            PopupMenuItem<String>(
                                child: Row(
                                  children: [
                                    Flag.fromCode(
                                      FlagsCode.SA,
                                      height: 20,
                                      width: 50,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    const Text(
                                      'العربية',
                                      style: TextStyle(fontFamily: 'Arabic'),
                                    ),
                                  ],
                                ),
                                value: 'العربية'),
                          ],
                      onSelected: (value) {
                        setState(() {
                          switch (value) {
                            case 'English':
                              context
                                  .read<LanguageChangeProvider>()
                                  .changeLocal('en', 'English');
                              country = Flag.fromCode(FlagsCode.US);
                              countryName = 'English';
                              break;
                            case 'فارسی':
                              context
                                  .read<LanguageChangeProvider>()
                                  .changeLocal('fa', 'Iran');
                              country = Flag.fromCode(FlagsCode.IR);
                              countryName = 'فارسی';
                              break;
                            case 'العربية':
                              context
                                  .read<LanguageChangeProvider>()
                                  .changeLocal('ar', 'Arabic');
                              country = Flag.fromCode(FlagsCode.SA);
                              countryName = 'العربية';
                              break;
                          }
                        });
                      })),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                //cirAn = true;
              });
              context
                  .read<LanguageChangeProvider>()
                  .changeTheme(!themeProvider.darkTheme);
              if (animationController.status == AnimationStatus.forward ||
                  animationController.status == AnimationStatus.completed) {
                animationController.reset();
                animationController.forward();
              } else {
                animationController.forward();
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8, left: 8),
              child: SizedBox(
                width: AppBar().preferredSize.height - 4,
                height: AppBar().preferredSize.height - 4,
                //color: themeProvider.darkTheme ? themeProvider.darkBackgroundColor : themeProvider.lightBackgroundColor,
                child: themeProvider.darkTheme
                    ? Lottie.asset('assets/images/moon.json',
                        reverse: true, animate: true)
                    : Lottie.asset('assets/images/sun.json',
                        reverse: true, animate: true),
              ),
            ),
          ),
        ],
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        //leftCornerRadius: 32,
        //rightCornerRadius: 32,
        backgroundColor: themeProvider.darkTheme
            ? AppTheme.blackAccent
            : context.read<LanguageChangeProvider>().currentColor,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        //other params
      ),
    );
  }

  Widget appBar(themeProvider) {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Container(
        //color: themeProvider.darkTheme ? AppTheme.nearlyBlack : Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*Padding(
              padding: const EdgeInsets.only(right: 8, left: 8),
              child: SizedBox(
                width: AppBar().preferredSize.height - 8,
                height: AppBar().preferredSize.height - 8,
                //color: themeProvider.darkTheme ? themeProvider.darkBackgroundColor : themeProvider.lightBackgroundColor,
                child: Material(
                    color: Colors.transparent,
                    child: PopupMenuButton(
                        icon: country,
                        iconSize: 30,
                        //icon: icon,
                        itemBuilder: (_) => <PopupMenuItem<String>>[
                              PopupMenuItem<String>(
                                  child: Row(
                                    children: [
                                      Flag.fromCode(
                                        FlagsCode.IR,
                                        height: 20,
                                        width: 50,
                                        fit: BoxFit.scaleDown,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      const Text(
                                        'فارسی',
                                        style: TextStyle(fontFamily: 'Iran'),
                                      ),
                                    ],
                                  ),
                                  value: 'فارسی'),
                              PopupMenuItem<String>(
                                  child: Row(
                                    children: [
                                      Flag.fromCode(
                                        FlagsCode.US,
                                        height: 20,
                                        width: 50,
                                        fit: BoxFit.scaleDown,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      const Text(
                                        'English',
                                        style: TextStyle(fontFamily: 'English'),
                                      ),
                                    ],
                                  ),
                                  value: 'English'),
                              PopupMenuItem<String>(
                                  child: Row(
                                    children: [
                                      Flag.fromCode(
                                        FlagsCode.SA,
                                        height: 20,
                                        width: 50,
                                        fit: BoxFit.scaleDown,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      const Text(
                                        'العربية',
                                        style: TextStyle(fontFamily: 'Arabic'),
                                      ),
                                    ],
                                  ),
                                  value: 'العربية'),
                            ],
                        onSelected: (value) {
                          setState(() {
                            switch (value) {
                              case 'English':
                                context
                                    .read<LanguageChangeProvider>()
                                    .changeLocal('en', 'English');
                                country = Flag.fromCode(FlagsCode.US);
                                break;
                              case 'فارسی':
                                context
                                    .read<LanguageChangeProvider>()
                                    .changeLocal('fa', 'Iran');
                                country = Flag.fromCode(FlagsCode.IR);
                                break;
                              case 'العربية':
                                context
                                    .read<LanguageChangeProvider>()
                                    .changeLocal('ar', 'Arabic');
                                country = Flag.fromCode(FlagsCode.SA);
                                break;
                            }
                          });
                        })),
              ),
            ),*/
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    S.of(context).app_name,
                    style: TextStyle(
                        fontSize: 25,
                        color:
                            context.read<LanguageChangeProvider>().currentColor,
                        fontWeight: FontWeight.w700,
                        fontFamily:
                            context.read<LanguageChangeProvider>().currentFont),
                  ),
                ),
              ),
            ),
            /*GestureDetector(
              onTap: () {
                setState(() {
                  //cirAn = true;
                });
                context
                    .read<LanguageChangeProvider>()
                    .changeTheme(!themeProvider.darkTheme);
                if (animationController.status == AnimationStatus.forward ||
                    animationController.status == AnimationStatus.completed) {
                  animationController.reset();
                  animationController.forward();
                } else {
                  animationController.forward();
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: SizedBox(
                  width: AppBar().preferredSize.height - 4,
                  height: AppBar().preferredSize.height - 4,
                  //color: themeProvider.darkTheme ? themeProvider.darkBackgroundColor : themeProvider.lightBackgroundColor,
                  child: themeProvider.darkTheme
                      ? Lottie.asset('assets/images/moon.json',
                          reverse: true, animate: true)
                      : Lottie.asset('assets/images/sun.json',
                          reverse: true, animate: true),
                ),
              ),
            ),*/
            /*Padding(
              padding:
                  const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
              child: SizedBox(
                width: AppBar().preferredSize.height - 8,
                height: AppBar().preferredSize.height - 8,
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
