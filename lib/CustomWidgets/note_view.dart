import 'dart:math';

import 'package:flutter/material.dart';
import 'package:note/CustomWidgets/note.dart';
import 'package:note/Provider/language_change_provider.dart';
import 'package:note/ThemeConfig/app_theme.dart';
import 'package:provider/provider.dart';

class NoteView extends StatefulWidget {
  const NoteView(Key? key, this._note) : super(key: key);

  final Note _note;
  @override
  _NoteViewState createState() => _NoteViewState(_note);
}

class _NoteViewState extends State<NoteView> with TickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;
  final Note _note;
  List<Color> backgrounds = [
    AppTheme.blackAccent,
    AppTheme.yellow,
    AppTheme.pink,
    AppTheme.green,
    AppTheme.blue
  ];

  _NoteViewState(this._note);

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<LanguageChangeProvider>(context);
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: backgrounds[Random(5).nextInt(5)],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                      topRight: Radius.circular(8.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: themeProvider.darkTheme
                            ? AppTheme.white.withOpacity(0.3)
                            : Colors.grey.withOpacity(0.5),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 1.0),
                  ],
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Text(_note.title),
                        Container(
                          height: 2,
                          color: themeProvider.darkTheme
                              ? AppTheme.white.withOpacity(0.3)
                              : AppTheme.blackAccent.withOpacity(0.3),
                        ),
                        Text(
                          _note.content,
                          softWrap: true,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
