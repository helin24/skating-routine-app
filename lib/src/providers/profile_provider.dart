import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/foundation.dart';
import 'package:skating_routine_app/src/models/skating_element.dart';
import 'package:skating_routine_app/src/models/user.dart';
import 'package:skating_routine_app/src/services/database_helper.dart';

class ProfileProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  User? _user;

  User? get user => _user;

  Future<void> loadProfile(String firebaseUid) async {
    _user = await _dbHelper.getUserByFirebaseUid(firebaseUid);
    if (_user == null) {
      final newUser = User(
        firebaseUid: firebaseUid,
        name: 'New Skater',
        level: SkatingLevel.prePreliminary,
        rotationDirection: RotationDirection.counterClockwise,
      );
      await _dbHelper.upsertUser(newUser);
      _user = await _dbHelper.getUserByFirebaseUid(firebaseUid);
    }
    notifyListeners();
  }

  Future<void> updateProfile(User user) async {
    await _dbHelper.upsertUser(user);
    _user = user;
    notifyListeners();
  }

  void clearProfile() {
    _user = null;
    notifyListeners();
  }
}
