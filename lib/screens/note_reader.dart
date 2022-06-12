import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplenote/models/note.dart';
import 'package:simplenote/models/note_provider.dart';
import 'package:simplenote/sqldb.dart';

import '../style/app_style.dart';
import 'note_editor.dart';

class NoteReader extends StatelessWidget {
  static const String routeName = '/note-reader';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NoteProvider>(context);
    final noteItem = ModalRoute.of(context)!.settings.arguments as Note;

    int color_id = int.parse(noteItem.colorid);

    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.edit,color: Colors.black54,),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(
            NoteEditor.routeName,arguments: noteItem
          );
        },
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await provider.deleteNotes(noteItem.id);

                Navigator.pop(context);
              },
              icon: Icon(Icons.delete))
        ],
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: AppStyle.cardsColor[color_id],
        titleTextStyle: TextStyle(color: Colors.black),
        title: Text(
          noteItem.title,
          style: AppStyle.mainTitle,
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 4,
            ),
            Text(
              noteItem.creationdate,
              style: AppStyle.dateTitle,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              noteItem.note,
              style: AppStyle.mainContent,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
