import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'book_model.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._internal();
  AppDatabase._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'books_v2.db');  // <-- new filename

    return await openDatabase(
      path,
      version: 3,
      onCreate: _createTable,
      onUpgrade: _upgradeDB,
    );
  }

  Future<void> _createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE books (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        author TEXT NOT NULL,
        genre TEXT NOT NULL,
        coverPath TEXT NOT NULL,
        totalPages INTEGER NOT NULL,
        pagesRead INTEGER NOT NULL,
        isFinished INTEGER NOT NULL DEFAULT 0
      )
    ''');
     await db.execute('''
    CREATE TABLE session (
      id INTEGER PRIMARY KEY,
      email TEXT,
      isLoggedIn INTEGER NOT NULL DEFAULT 0
    )
  ''');
  }
  Future<void> saveSession(String email) async {
  final db = await instance.database;
  await db.delete('session'); // only ever keep 1 row
  await db.insert('session', {'id': 1, 'email': email, 'isLoggedIn': 1});
}

Future<String?> getSavedEmail() async {
  final db = await instance.database;
  final result = await db.query('session', where: 'isLoggedIn = ?', whereArgs: [1]);
  if (result.isEmpty) return null;
  return result.first['email'] as String;
}

Future<void> clearSession() async {
  final db = await instance.database;
  await db.delete('session');
}
  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    await db.execute('DROP TABLE IF EXISTS books');
    await _createTable(db, newVersion);
  }

  Future<int> insertBook(Book book) async {
    final db = await instance.database;
    return await db.insert('books', book.toMap());
  }

  Future<List<Book>> getAllBooks() async {
    final db = await instance.database;
    final result = await db.query('books');
    return result.map((map) => Book.fromMap(map)).toList();
  }

  Future<int> updateBook(Book book) async {
    final db = await instance.database;
    return await db.update(
      'books',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  Future<int> deleteBook(int id) async {
    final db = await instance.database;
    return await db.delete(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  // Books currently being read (for the top screen)
Future<List<Book>> getCurrentlyReadingBooks() async {
  final db = await instance.database;
  final result = await db.query('books', where: 'isFinished = ?', whereArgs: [0]);
  return result.map((map) => Book.fromMap(map)).toList();
}

// Books marked as finished (for fbook.dart)
Future<List<Book>> getFinishedBooks() async {
  final db = await instance.database;
  final result = await db.query('books', where: 'isFinished = ?', whereArgs: [1]);
  return result.map((map) => Book.fromMap(map)).toList();
}
}