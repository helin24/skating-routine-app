import 'package:flutter/foundation.dart';
import 'package:skating_routine_app/src/models/skating_element.dart';
import 'package:skating_routine_app/src/models/user.dart';
import 'package:skating_routine_app/src/services/database_helper.dart';

class ProfileProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  User? _user;

  User? get user => _user;

  Future<void> loadProfile(int userId) async {
    _user = await _dbHelper.getUser(userId);
    if (_user == null) {
      final defaultUser = User(
        id: userId,
        name: 'Default User',
        level: SkatingLevel.preliminary,
        rotationDirection: RotationDirection.counterClockwise,
      );
      await _dbHelper.upsertUser(defaultUser);
      _user = defaultUser;
    }
    notifyListeners();
  }

  Future<void> updateProfile(User user) async {
    await _dbHelper.upsertUser(user);
    _user = user;
    notifyListeners();
  }
}
