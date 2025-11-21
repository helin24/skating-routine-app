import 'package:path/path.dart';
import 'package:skating_routine_app/src/models/routine.dart';
import 'package:skating_routine_app/src/models/user.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Singleton pattern
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'skating_routines.db');

    return await openDatabase(path,
        version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firebaseUid TEXT,
        name TEXT NOT NULL,
        level TEXT NOT NULL,
        rotationDirection TEXT NOT NULL
      )
    ''');

    // The routines and routine_elements tables are no longer needed
    // as this data is now stored in Firestore.
    // They are kept here for now to prevent breaking existing local-only versions
    // of the app, but would be removed in a future migration.
    await db.execute('''
      CREATE TABLE routines(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,
        name TEXT NOT NULL,
        FOREIGN KEY (userId) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE routine_elements(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        routineId INTEGER NOT NULL,
        elementId INTEGER NOT NULL,
        "order" INTEGER NOT NULL,
        FOREIGN KEY (routineId) REFERENCES routines (id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE users ADD COLUMN firebaseUid TEXT');
    }
    if (oldVersion < 3) {
      // Migration to remove skating_elements table if it exists
      // For simplicity, we are not implementing this now, but in a real app
      // you would handle schema changes carefully.
    }
  }

  // Methods for User
  Future<int> upsertUser(User user) async {
    final db = await database;
    return await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User?> getUserByFirebaseUid(String uid) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'firebaseUid = ?',
      whereArgs: [uid],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
