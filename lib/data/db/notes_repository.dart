import 'package:flutter_notes_app/data/models/note.dart';

import '../repository.dart';

class NotesRepository extends Repository{
  @override
  void close() {
    // TODO: implement close
  }

  @override
  Future<void> deleteNote(Note note) {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<List<Note>> findAllNotes() {
    // TODO: implement findAllNotes
    throw UnimplementedError();
  }

  @override
  Future<Note> findNoteById(int id) {
    // TODO: implement findNoteById
    throw UnimplementedError();
  }

  @override
  Future init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<int> insertNote(Note note) {
    // TODO: implement insertNote
    throw UnimplementedError();
  }

  @override
  Future<int> updateNote(Note note) {
    // TODO: implement updateNote
    throw UnimplementedError();
  }

  @override
  Stream<List<Note>> watchAllNotes() {
    // TODO: implement watchAllNotes
    throw UnimplementedError();
  }
}