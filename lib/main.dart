import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplenote/models/note_provider.dart';
import 'package:simplenote/screens/home_screen.dart';

import 'screens/note_editor.dart';
import 'screens/note_reader.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => NoteProvider()),
        ),
      ],
      child: MaterialApp(
        routes: {
          HomeScreen.routeName:(context) =>  HomeScreen(),
          NoteReader.routeName:(context) =>  NoteReader(),
          NoteEditor.routeName:(context) =>  NoteEditor(),

        },
      ),
    );
  }
}
