import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:note/CustomWidgets/note.dart';
import 'package:note/Database/hive_db.dart';
import 'package:note/Provider/language_change_provider.dart';
import 'package:note/Provider/permission_service.dart';
import 'package:note/generated/l10n.dart';
import 'package:provider/src/provider.dart';

HiveDataBase hiveDB = HiveDataBase();
class NewNote extends StatefulWidget {
  const NewNote({Key? key, this.note, required this.flag}) : super(key: key);
  final String flag;
  final Note? note;

  @override
  _NewNoteState createState() => _NewNoteState(flag: flag, note: note);
}

class _NewNoteState extends State<NewNote> with TickerProviderStateMixin {
  late TextEditingController _titleControler, _contentControler;
  final String flag;
  final Note? note;

  _NewNoteState({required this.flag, this.note});

  @override
  void initState() {
    _titleControler = TextEditingController();
    _contentControler = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleControler.dispose();
    _contentControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            appBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: S.of(context).note_title),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontFamily: context
                                  .read<LanguageChangeProvider>()
                                  .currentFont),
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          cursorColor: context
                              .read<LanguageChangeProvider>()
                              .currentColor,
                          maxLines: null,
                          controller: _titleControler),
                      TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: S.of(context).note_content),
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: context
                                  .read<LanguageChangeProvider>()
                                  .currentFont),
                          keyboardType: TextInputType.multiline,
                          cursorColor: context
                              .read<LanguageChangeProvider>()
                              .currentColor,
                          maxLines: null,
                          controller: _contentControler),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Container(
        //color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8, left: 8),
              child: SizedBox(
                width: AppBar().preferredSize.height - 8,
                height: AppBar().preferredSize.height - 8,
                //color: themeProvider.darkTheme ? themeProvider.darkBackgroundColor : themeProvider.lightBackgroundColor,
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    S.of(context).add_note,
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
            Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8),
              child: SizedBox(
                width: AppBar().preferredSize.height - 2,
                height: AppBar().preferredSize.height - 2,
                child: IconButton(
                  onPressed: () {
                    PermissionService permissionService = PermissionService();
                    permissionService.requestPermission();
                    if (flag == 'edit') {
                      Note _note = Note(
                          _titleControler.text,
                          _contentControler.text,
                          DateTime.now()
                      );
                      hiveDB.updateNote(note!.key, _note);
                    } else {
                      Note _note = Note(
                          _titleControler.text,
                          _contentControler.text,
                          DateTime.now());
                      hiveDB.addNote(_note);
                    }
                    print("Add Note");
                    Navigator.pop(context);
                  },
                  icon: Lottie.asset('assets/images/tick.json') /*Icon(
                      Icons.check,
                    color: context.read<LanguageChangeProvider>().currentColor,
                  ),*/
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
