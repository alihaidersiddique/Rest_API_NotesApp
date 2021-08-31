import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api_notes_app/models/api_response.dart';
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

  final APIResponse<List<Notes>> _apiResponse;

  bool _isLoading = false;

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getNotesList();

    setState(() {
      _isLoading = false;
    });
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
        body: Builder(
          builder: (context) {
            if (_isLoading) {
              return CircularProgressIndicator();
            }
            if (_apiResponse.error) {
              return Center(child: Text(_apiResponse.errorMessage as String));
            }
            return ListView.separated(
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {},
                    confirmDismiss: (direction) async {
                      final result = await showDialog(
                          context: context,
                          builder: (context) => NotesDelete());
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
                              builder: (context) => NotesModify(
                                  noteID: _apiResponse.data![index].noteID),
                            ));
                      },
                      title: Text(
                        _apiResponse.data![index].noteTitle,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      subtitle: Text(
                          'Last edited on ${formatDateTime(_apiResponse.data![index].lastEditDateTime)}'),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    Divider(height: 1, color: Colors.green),
                itemCount: _apiResponse.data!.length);
          },
        ));
  }
}
