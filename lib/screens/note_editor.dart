import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simplenote/models/note.dart';
import 'package:simplenote/models/note_provider.dart';
import 'package:simplenote/screens/home_screen.dart';

import '../sqldb.dart';
import '../style/app_style.dart';

class NoteEditor extends StatelessWidget {
  static const String routeName = '/note-editor';

  int colors_id = Random().nextInt(AppStyle.cardsColor.length);

  String formattedDate =
      DateFormat('MMM d, yyyy, h:mm a').format(DateTime.now());

  TextEditingController _titleController = TextEditingController();

  TextEditingController _mainController = TextEditingController();
  bool _isExisting = false;
  @override
  Widget build(BuildContext context) {
    Note item = ModalRoute.of(context)?.settings.arguments as Note;
    if (item.id != 'FirstAdd') {
      _isExisting = true;
      _titleController.text = item.title;
      _mainController.text = item.note;
      //colors_id = int.parse(item.colorid);
      //formattedDate = item.creationdate;
    }

    final provider = Provider.of<NoteProvider>(context, listen: false);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          if (_isExisting) {
            await provider.updateNotes({
              'id': item.id,
              'creationdate': formattedDate,
              'title': _titleController.text,
              'note': _mainController.text,
              'colorid': colors_id.toString(),
            }, item.id).then((value) => Navigator.of(context).pop());
          } else if (!_isExisting) {
            String password = provider.getRandomString(5);
            await provider.insertNotes({
              'id': 'pass$password',
              'creationdate': formattedDate,
              'title': _titleController.text,
              'note': _mainController.text,
              'colorid': colors_id.toString(),
            }).then((value) => Navigator.of(context).pop());
          }
        },
        child: Icon(Icons.save_rounded, color: Colors.black54),
      ),
      backgroundColor: AppStyle.cardsColor[colors_id],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: AppStyle.cardsColor[colors_id],
        elevation: 0,
        title: Text(
          "Add a new Note",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Note Title'),
              style: AppStyle.mainTitle,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              formattedDate,
              style: AppStyle.dateTitle,
            ),
            SizedBox(
              height: 28,
            ),
            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Note Content'),
              style: AppStyle.mainContent,
            ),
          ],
        ),
      ),
    );
  }
}
