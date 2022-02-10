import 'models/models.dart';

abstract class Repository {
  Future<List<Note>> findAllNotes();

  Stream<List<Note>> watchAllNotes();

  Future<Note> findNoteById(int id);

  Future<int> insertNote(Note note);

  Future<int> updateNote(Note note);

  Future<void> deleteNote(Note note);

  Future init();
  void close();

}
