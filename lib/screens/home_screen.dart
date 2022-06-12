import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simplenote/models/note.dart';
import 'package:simplenote/models/note_provider.dart';
import 'package:simplenote/widgets/note_card.dart';

import '../sqldb.dart';
import '../style/app_style.dart';
import 'note_editor.dart';
import 'note_reader.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NoteProvider>(context);

    provider.fetchAndSetNotes();

    final value = provider.notes;

    return Scaffold(
      backgroundColor: AppStyle.primaryColor,
      appBar: AppBar(
        title: Text('FireNote'),
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppStyle.primaryColor,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your recent Notes',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: value.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (ctx, i) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NoteCard(
                        onTap: () {
                          Navigator.of(context).pushNamed(NoteReader.routeName,
                              arguments: value[i]);
                        },
                        colorId: value[i].colorid,
                        dateTime: value[i].creationdate,
                        title: value[i].title,
                        note: value[i].note,
                      ),
                    ),
                  ),
                ),
              ])),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        onPressed: () {
          //   SqlDb sqlDb = SqlDb();
          //  await sqlDb.deleteDatabase();
          Navigator.of(context).pushNamed(NoteEditor.routeName,
              arguments: Note(
                  id: 'FirstAdd',
                  creationdate: '',
                  title: '',
                  note: '',
                  colorid: ''));
        },
        label: Text(
          'Add Note',
          style: TextStyle(color: Colors.black54),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.black54,
        ),
      ),
    );
  }
}
