import 'package:flutter/material.dart';
import 'package:note_app/pages/notes_page.dart';
import 'package:note_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import 'models/note_database.dart';

void main() async{

  // initialize note isar database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();
  runApp(
      MultiProvider(providers: [
        //Note provider
        ChangeNotifierProvider(create: (context) => NoteDatabase(),),
        //Theme Provider
        ChangeNotifierProvider(create: (context) => ThemeProvider(),),
      ],
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}


