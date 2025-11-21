import 'package:flutter_test/flutter_test.dart';
import 'package:skating_routine_app/src/services/database_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Initialize FFI for sqflite
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group('DatabaseHelper', () {
    late DatabaseHelper dbHelper;

    setUp(() async {
      dbHelper = DatabaseHelper();
      // Make sure we have a clean database for each test
      await dbHelper.database;
    });

    tearDown(() async {
      await dbHelper.close();
    });

    test('database can be initialized', () async {
      final db = await dbHelper.database;
      expect(db.isOpen, isTrue);
    });
  });
}
