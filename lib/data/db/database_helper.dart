import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:synchronized/synchronized.dart';

import '../models/models.dart';

class DatabaseHelper {
  static const _databaseName = 'notes.db';
  static const _databaseVersion = 1;

  static const noteTable = 'Note';
  static const noteId = 'noteId';

  static late BriteDatabase _streamDatabase;

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static var lock = Lock();

  // only have a single app-wide reference to the database
  static Database? _database;

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $noteTable (
          $noteId INTEGER PRIMARY KEY,
          title TEXT,
          description TEXT,
          date TEXT,
          color INTEGER,
          priority INTEGER
        )
        ''');
  }

  // this opens the database (and creates it if it doesn't exist)
  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    Sqflite.setDebugModeOn(true);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Use this object to prevent concurrent access to data
    await lock.synchronized(
      () async {
        // lazily instantiate the db the first time it is accessed
        if (_database == null) {
          _database = await _initDatabase();
          _streamDatabase = BriteDatabase(_database!);
        }
      },
    );
    return _database!;
  }

  Future<BriteDatabase> get streamDatabase async {
    await database;
    return _streamDatabase;
  }

  List<Note> parseRecipes(List<Map<String, dynamic>> noteList) {
    final notes = <Note>[];
    for (var recipeMap in noteList) {
      final recipe = Note.fromJson(recipeMap);
      notes.add(recipe);
    }
    return notes;
  }

  Future<List<Note>> findAllNotes() async {
    final db = await instance.streamDatabase;
    final noteList = await db.query(noteTable);
    final notes = parseRecipes(noteList);
    return notes;
  }

  Stream<List<Note>> watchAllNotes() async* {
    final db = await instance.streamDatabase;
    yield* db.createQuery(noteTable).mapToList((row) => Note.fromJson(row));
  }

  Future<Note> findNoteById(int id) async {
    final db = await instance.streamDatabase;
    final noteList = await db.query(noteTable, where: 'id = $id');
    final notes = parseRecipes(noteList);
    return notes.first;
  }

  Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await instance.streamDatabase;
    return db.insert(table, row);
  }

  Future<int> insertNote(Note note) {
    return insert(noteTable, note.toJson());
  }

  Future<int> _update(String table, Map<String, dynamic> row, int id) async {
    final db = await instance.streamDatabase;
    return db.update(
      table,
      row,
      where: '$noteId = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateNote(Note note) {
    return _update(noteTable, note.toJson(), note.id ?? 0);
  }

  Future<int> _delete(String table, String columnId, int id) async {
    final db = await instance.streamDatabase;
    return db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteNote(Note note) async {
    if (note.id != null) {
      return _delete(noteTable, noteId, note.id!);
    } else {
      return Future.value(-1);
    }
  }

  void close() {
    _streamDatabase.close();
  }
}
