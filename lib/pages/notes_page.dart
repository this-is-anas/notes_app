import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/component/note_tile.dart';
import 'package:note_app/models/note_database.dart';
import 'package:provider/provider.dart';

import '../component/drawer.dart';
import '../models/note.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  //Textcontroller to access what user types
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //On app startup fetch the existing note
    readNotes();
  }

  //Create a note
  void creatNote(){
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      content: TextField(
        controller: textController,
      ),
      actions: [
        //Create Button
        MaterialButton(onPressed: (){
          //Add to the database
          context.read<NoteDatabase>().addNote(textController.text);

          //Clear the controler
          textController.clear();
          
          //Pop the dialog
          Navigator.pop(context);
        },
          child: Text("Create"),
        )
      ],
    ),);
  }
  //Read a note
  void readNotes(){
    context.read<NoteDatabase>().fetchNotes();
  }
  //Update a note
  void updateNote(Note note){
    //Pre-fill the current note text
    textController.text = note.text;
    //
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("Update Note"),
      content: TextField(controller: textController,),
      actions: [
        MaterialButton(onPressed: (){
          //Update note in database
          context.read<NoteDatabase>().updateNote(note.id, textController.text);
          //Clear the controller
          textController.clear();
          //Pop the dialog
          Navigator.pop(context);
        },
        child: Text("Update"),
        )
      ],
    ),);
  }

  //Delete a note
  void deleteNote(int id){
    context.read<NoteDatabase>().deleteNote(id);
  }

  

  @override
  Widget build(BuildContext context) {

    //Access the database
    final noteDatabase = context.watch<NoteDatabase>();
    //Crate the list of notes
    List<Note> currentNotes = noteDatabase.currentNotes;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.surface,

      floatingActionButton: FloatingActionButton(onPressed: creatNote,
      child: Icon(Icons.add, color: Theme.of(context).colorScheme.inversePrimary,),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //HEADING
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text("Notes",
            style: GoogleFonts.dmSerifText(fontSize: 48,
            color: Theme.of(context).colorScheme.inversePrimary,
            ),
            ),
          ),

          //LIST OF NOTES
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
              //get individual note
              final note = currentNotes[index];
            
              //List tile ui
              return NoteTile(
                text: note.text,
                onEditPressed: () => updateNote(note),
                onDeletePressed: () => deleteNote(note.id),
              );
            },),
          ),
        ],
      ),
    );
  }
}
