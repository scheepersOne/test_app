import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_database_example/model/note.dart';

class NotesDatabase {
  //instance of db
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  //Private constructor.
  NotesDatabase._init();

  //Gets DB if exists, else creates one and returns DB either way.
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('db6.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    final doubleType = 'REAL';

    await db.execute('''
CREATE TABLE $tableNotes ( 
  ${NoteFields.idField} $idType, 
  ${NoteFields.lengthField} $integerType,
  ${NoteFields.widthField} $integerType,
  ${NoteFields.tempField} $integerType,
  ${NoteFields.applesField} $doubleType,
  ${NoteFields.spoiledField} $doubleType,
  ${NoteFields.oldSpoiledField} $doubleType,
  ${NoteFields.applePriceField} $doubleType,
  ${NoteFields.fertField} $integerType,
  ${NoteFields.oldFertField} $integerType,
  ${NoteFields.fertPriceField} $integerType,
  ${NoteFields.oldFertPriceField} $integerType,
  ${NoteFields.applesSoldField} $integerType,
  ${NoteFields.oldApplesSoldField} $integerType,
  ${NoteFields.priceSoldField} $integerType,
  ${NoteFields.cashReceivedField} $integerType,
  ${NoteFields.oldCashReceivedField} $integerType,
  ${NoteFields.titleField} $textType,
  ${NoteFields.timeField} $textType
  )
''');
  }

  //Creates Note.
  Future<Note> create(Note note) async {
    final db = await instance.database;

    final id = await db.insert(tableNotes, note.toJson());
    return note.copy(copyId: id);
  }

  //Read Note.
  Future<Note> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNotes,
      columns: NoteFields.values,
      where: '${NoteFields.idField} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  //Read All Notes, in RefreshNotes.
  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;

    final orderBy = '${NoteFields.timeField} ASC';

    final result = await db.query(tableNotes, orderBy: orderBy);

    return result.map((json) => Note.fromJson(json)).toList();
  }

  //Update Note.
  Future<int> update(Note note) async {
    final db = await instance.database;

    return db.update(
      tableNotes,
      note.toJson(),
      where: '${NoteFields.idField} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableNotes,
      where: '${NoteFields.idField} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
