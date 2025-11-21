import 'package:path/path.dart';
import 'package:skating_routine_app/src/models/skating_element.dart';
import 'package:skating_routine_app/src/models/routine.dart';
import 'package:skating_routine_app/src/models/user.dart';
import 'package:skating_routine_app/src/services/initial_data.dart';
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

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        level TEXT NOT NULL,
        rotationDirection TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE skating_elements(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        code TEXT NOT NULL,
        type TEXT NOT NULL,
        minLevel TEXT NOT NULL,
        entryEdge TEXT,
        entryFoot TEXT,
        isToeAssist INTEGER NOT NULL,
        exitEdge TEXT,
        exitFoot TEXT
      )
    ''');

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
        FOREIGN KEY (routineId) REFERENCES routines (id) ON DELETE CASCADE,
        FOREIGN KEY (elementId) REFERENCES skating_elements (id) ON DELETE CASCADE
      )
    ''');

    await _populateInitialData(db);
  }

  Future<void> _populateInitialData(Database db) async {
    for (final element in initialElements) {
      await db.insert('skating_elements', element.toMap());
    }
  }

  // Methods for SkatingElement
  Future<int> insertElement(SkatingElement element) async {
    final db = await database;
    return await db.insert('skating_elements', element.toMap());
  }

  Future<List<SkatingElement>> getElements() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('skating_elements');
    return List.generate(maps.length, (i) {
      return SkatingElement.fromMap(maps[i]);
    });
  }

  Future<List<SkatingElement>> searchElements(String query) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'skating_elements',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
    );
    return List.generate(maps.length, (i) {
      return SkatingElement.fromMap(maps[i]);
    });
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

  Future<User?> getUser(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<User>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  // Methods for Routine
  Future<int> insertRoutine(Routine routine) async {
    final db = await database;
    final routineId = await db.insert(
      'routines',
      routine.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Clear existing elements for this routine and insert new ones
    await db.delete(
      'routine_elements',
      where: 'routineId = ?',
      whereArgs: [routineId],
    );
    for (int i = 0; i < routine.elements.length; i++) {
      // This assumes the element object has a valid ID from the database.
      await db.insert('routine_elements', {
        'routineId': routineId,
        'elementId': routine.elements[i].id,
        'order': i,
      });
    }
    return routineId;
  }

  Future<List<Routine>> getRoutinesForUser(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> routineMaps = await db.query(
      'routines',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    List<Routine> routines = [];
    for (var routineMap in routineMaps) {
      final routine = Routine.fromMap(routineMap);
      final List<Map<String, dynamic>> elementMaps = await db.rawQuery(
        '''
        SELECT se.* FROM skating_elements se
        INNER JOIN routine_elements re ON se.id = re.elementId
        WHERE re.routineId = ?
        ORDER BY re."order" ASC
      ''',
        [routine.id],
      );

      routine.elements.addAll(
        elementMaps.map((e) => SkatingElement.fromMap(e)),
      );
      routines.add(routine);
    }
    return routines;
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
