import 'dart:ffi';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:simplenote/models/note.dart';
import 'package:simplenote/sqldb.dart';

class NoteProvider with ChangeNotifier {
  SqlDb sqlDb = SqlDb();
  List<Note> _notes = [];

  List<Note> get notes {
    return [..._notes];
  }

  Map<String, String> noteToMap(Note note) {
    return {
      'id': note.id,
      'creationdate': note.creationdate,
      'title': note.title,
      'note': note.note,
      'colorid': note.colorid,
    };
  }

  Note fromMapToNote(Map note) {
    return Note(
      id: note['id'],
      creationdate: note['creationdate'],
      title: note['title'],
      note: note['note'],
      colorid: note['colorid'],
    );
  }

  Future<void> fetchAndSetNotes() async {
    List<Map> response = await sqlDb.readData('notes');

    if (_notes.isEmpty) {
      print('not empty okkkkkkkkkkkkkkkkkk');
      response.forEach(
        (element) {
          _notes.add(fromMapToNote(element));
        },
      );
    }

    notifyListeners();
  }

  String getRandomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(
          _rnd.nextInt(
            _chars.length,
          ),
        ),
      ),
    );
  }

  Future<void> insertNotes(Map<String, String> map) async {
    _notes.add(fromMapToNote(map));
    await sqlDb.insertData('notes', map);
    notifyListeners();
  }

  Future<void> deleteNotes(String id) async {
    _notes.removeWhere((element) => element.id == id);
    await sqlDb.deleteData(id);
    notifyListeners();
  }

  Future<void> updateNotes(Map<String, Object?> map, String id) async {
    Note notey = fromMapToNote(map);
    int index = _notes.indexWhere((element) => element.id == notey.id);
    _notes[index] = notey;
    await sqlDb.updateData('notes', map, id);
    notifyListeners();
  }
}
