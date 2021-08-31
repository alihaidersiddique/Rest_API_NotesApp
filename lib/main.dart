import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api_notes_app/services/notes_service.dart';
import 'package:rest_api_notes_app/views/notes_list.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => NotesService());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: NotesList(),
    );
  }
}
