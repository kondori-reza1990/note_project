import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note/CustomWidgets/note.dart';
import 'package:path_provider/path_provider.dart';

class HiveDataBase with ChangeNotifier {
  static const String noteDb = "note";
  late Directory documentsDirectory;

  HiveDataBase();

  initialize() async {
    if (Platform.isAndroid || Platform.isIOS) {
      documentsDirectory = (await getExternalStorageDirectory())!;
    } else {
      documentsDirectory = await getApplicationSupportDirectory();
    }
    Hive.init(documentsDirectory.path);
    //await Hive.initFlutter(documentsDirectory.path);
    Hive.registerAdapter(NoteAdapter());
  }

  Future<Box> openNoteBox() async {
    var noteBox = await Hive.openBox(noteDb);
    return noteBox;
  }

  void deleteBoxes() {
    openNoteBox().then((value) => value.deleteFromDisk());
  }

  List _noteList = <Note>[];
  List get noteList => _noteList;
  addNote(Note note) async {
    var box = await openNoteBox();
    box.add(note);
    notifyListeners();
  }

  Future<List> getNotes() async {
    final box = await openNoteBox();
    _noteList = box.values.toList();
    notifyListeners();
    return _noteList;
  }

  getNote(int index) async {
    final box = await openNoteBox();
    Note note = box.get(index);
    return note;
  }

  updateNote(int index, Note note) {
    openNoteBox().then((box) => box.put(index, note));
    notifyListeners();
  }

  deleteNote(int id) async {
    openNoteBox().then((box) => box.delete(id));
    notifyListeners();
  }
}
