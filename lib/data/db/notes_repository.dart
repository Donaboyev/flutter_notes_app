import 'package:flutter_notes_app/data/models/note.dart';

import '../repository.dart';
import '../models/models.dart';
import 'app_db.dart';

class NotesRepository extends Repository {
  late AppDatabase appDatabase;
  late NoteDao _noteDao;
  Stream<List<Note>>? noteStream;

  @override
  void close() {
    appDatabase.close();
  }

  @override
  Future<void> deleteNote(Note note) {
    if (note.id != null) {
      _noteDao.deleteNote(note.id!);
    }
    return Future.value();
  }

  @override
  Future<List<Note>> findAllNotes() {
    return _noteDao.findAllNotes().then<List<Note>>(
      (List<MoorNoteData> moorNotes) {
        final notes = <Note>[];
        for (var moorNote in moorNotes) {
          final note = moorNoteToNote(moorNote);
          notes.add(note);
        }
        return notes;
      },
    );
  }

  @override
  Future<Note> findNoteById(int id) {
    return _noteDao
        .findNoteById(id)
        .then((listOfNotes) => moorNoteToNote(listOfNotes.first));
  }

  @override
  Future init() async {
    appDatabase = AppDatabase();
    _noteDao = appDatabase.noteDao;
  }

  @override
  Future<int> insertNote(Note note) {
    return Future(
      () async {
        final id = await _noteDao.insertNote(noteToInsertableMoorNote(note));
        return id;
      },
    );
  }

  @override
  Future<bool> updateNote(Note note) {
    return Future(
          () async {
        final id = await _noteDao.updateNote(noteToInsertableMoorNote(note));
        return id;
      },
    );
  }

  @override
  Stream<List<Note>> watchAllNotes() {
    noteStream ??= _noteDao.watchAllNotes();
    return noteStream!;
  }
}
