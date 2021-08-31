import 'package:rest_api_notes_app/models/notes.dart';

class NotesService {
  List<Notes> getNotesList() {
    return [
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
  }
}
