import 'package:rest_api_notes_app/models/api_response.dart';
import 'package:rest_api_notes_app/models/notes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotesService {
  //
  static const API = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {'apiKey': '76c01c91-7bb1-457b-bf7f-5035c2bcf1bf'};

  Future<APIResponse<List<Notes>>> getNotesList() {
    return http.get(API + '/notes' as Uri, headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <Notes>[];
        for (var item in jsonData) {
          final note = Notes(
              noteID: item['noteID'],
              noteTitle: item['noteTitle'],
              createdDateTime: DateTime.parse(item['createDateTime']),
              lastEditDateTime: DateTime.parse(item['latestEditDateTime']));
          notes.add(note);
        }
        return APIResponse<List<Notes>>(data: notes);
      }
      return APIResponse<List<Notes>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<Notes>>(
        error: true, errorMessage: 'An error occured'));
  }
}
