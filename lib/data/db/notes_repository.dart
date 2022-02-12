import 'package:flutter_notes_app/data/models/note.dart';

import '../repository.dart';
import 'database_helper.dart';
import '../models/models.dart';

class NotesRepository extends Repository {
  final dbHelper = DatabaseHelper.instance;

  @override
  void close() {
    dbHelper.close();
  }

  @override
  Future<void> deleteNote(Note note) {
    dbHelper.deleteNote(note);
    return Future.value();
  }

  @override
  Future<List<Note>> findAllNotes() {
    return dbHelper.findAllNotes();
  }

  @override
  Future<Note> findNoteById(int id) {
    return dbHelper.findNoteById(id);
  }

  @override
  Future init() async{
    await dbHelper.database;
    return Future.value();
  }

  @override
  Future<int> insertNote(Note note) {
    return Future(
          () async {
        final id = await dbHelper.insertNote(note);
        return id;
      },
    );
  }

  @override
  Future<int> updateNote(Note note) {
    return Future(
          () async {
        final id = await dbHelper.updateNote(note);
        return id;
      },
    );
  }

  @override
  Stream<List<Note>> watchAllNotes() {
    return dbHelper.watchAllNotes();
  }
}
