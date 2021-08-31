import 'package:flutter/material.dart';
import 'package:rest_api_notes_app/models/notes.dart';
import 'package:rest_api_notes_app/views/notes_delete.dart';
import 'package:rest_api_notes_app/views/notes_modify.dart';

class NotesList extends StatelessWidget {
  //
  final notes = [
    Notes(
        noteID: '1',
        noteTitle: 'Note 1',
        createdDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now()),
    Notes(
        noteID: '2',
        noteTitle: 'Note 2',
        createdDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now()),
    Notes(
        noteID: '3',
        noteTitle: 'Note 3',
        createdDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now()),
  ];

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
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
              key: ValueKey(notes[index].noteID),
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
