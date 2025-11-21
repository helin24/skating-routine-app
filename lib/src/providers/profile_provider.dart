import 'package:flutter/foundation.dart';
import 'package:skating_routine_app/src/models/skating_element.dart';
import 'package:skating_routine_app/src/models/user.dart';
import 'package:skating_routine_app/src/services/database_helper.dart';

class ProfileProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<User> _users = [];
  User? _currentUser;

  List<User> get users => _users;
  User? get currentUser => _currentUser;

  Future<void> loadUsers() async {
    _users = await _dbHelper.getAllUsers();
    if (_users.isEmpty) {
      final defaultUser = User(
        name: 'Default User',
        level: SkatingLevel.prePreliminary,
        rotationDirection: RotationDirection.counterClockwise,
      );
      await _dbHelper.upsertUser(defaultUser);
      _users = await _dbHelper.getAllUsers();
    }
    notifyListeners();
  }

  void setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> createNewUser(String name) async {
    final newUser = User(
      name: name,
      level: SkatingLevel.prePreliminary,
      rotationDirection: RotationDirection.counterClockwise,
    );
    await _dbHelper.upsertUser(newUser);
    await loadUsers();
  }

  Future<void> updateProfile(User user) async {
    await _dbHelper.upsertUser(user);
    await loadUsers();
    _currentUser = user;
    notifyListeners();
  }
}
