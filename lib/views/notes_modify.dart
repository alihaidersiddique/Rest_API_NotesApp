import 'package:flutter/material.dart';

class NotesModify extends StatelessWidget {
  //
  final String? noteID;

  bool get isEditing => noteID != null;

  NotesModify({this.noteID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit note' : 'Create note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Note title'),
            ),
            SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(hintText: 'Note content'),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              height: 45.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
