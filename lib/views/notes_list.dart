import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api_notes_app/models/notes.dart';
import 'package:rest_api_notes_app/services/notes_service.dart';
import 'package:rest_api_notes_app/views/notes_delete.dart';
import 'package:rest_api_notes_app/views/notes_modify.dart';

class NotesList extends StatefulWidget {
  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  NotesService get service => GetIt.I<NotesService>();

  List<Notes> notes = [];

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    notes = service.getNotesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List of Notes')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotesModify(),
              ));
        },
        child: Icon(Icons.add),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {},
              confirmDismiss: (direction) async {
                final result = await showDialog(
                    context: context, builder: (context) => NotesDelete());
                //print(result);
                return result;
              },
              background: Container(
                color: Colors.red,
                padding: EdgeInsets.only(left: 16.0),
                child: Align(
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NotesModify(noteID: notes[index].noteID),
                      ));
                },
                title: Text(
                  notes[index].noteTitle,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                subtitle: Text(
                    'Last edited on ${formatDateTime(notes[index].lastEditDateTime)}'),
              ),
            );
          },
          separatorBuilder: (context, index) =>
              Divider(height: 1, color: Colors.green),
          itemCount: notes.length),
    );
  }
}
