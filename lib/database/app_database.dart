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
      version: 7,
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
      name TEXT,
      email TEXT,
      isLoggedIn INTEGER NOT NULL DEFAULT 0
    )
  ''');
  await db.execute('''
  CREATE TABLE settings (
    key TEXT PRIMARY KEY,
    value TEXT
  )
''');
  }
 Future<void> saveSession(String name, String email) async {
  final db = await instance.database;
  await db.delete('session');
  await db.insert('session', {'id': 1, 'name': name, 'email': email, 'isLoggedIn': 1});
}


Future<Map<String, String>?> getSavedSession() async {
  final db = await instance.database;
  final result = await db.query('session', where: 'isLoggedIn = ?', whereArgs: [1]);
  if (result.isEmpty) return null;
  return {
    'name': result.first['name'] as String,
    'email': result.first['email'] as String,
  };
}

Future<void> clearSession() async {
  final db = await instance.database;
  await db.delete('session');
}
  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
  await db.execute('DROP TABLE IF EXISTS books');
  await db.execute('DROP TABLE IF EXISTS session');
  await db.execute('DROP TABLE IF EXISTS settings');
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
Future<void> saveTheme(String mode) async {
  final db = await instance.database;
  await db.insert(
    'settings',
    {'key': 'theme', 'value': mode},
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<String?> getSavedTheme() async {
  final db = await instance.database;
  final result = await db.query('settings', where: 'key = ?', whereArgs: ['theme']);
  if (result.isEmpty) return null;
  return result.first['value'] as String?;
}
Future<void> saveColor(int colorValue) async {
  final db = await instance.database;
  await db.insert(
    'settings',
    {'key': 'accentColor', 'value': colorValue.toString()},
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<int?> getSavedColor() async {
  final db = await instance.database;
  final result = await db.query('settings', where: 'key = ?', whereArgs: ['accentColor']);
  if (result.isEmpty) return null;
  return int.tryParse(result.first['value'] as String);
}
}