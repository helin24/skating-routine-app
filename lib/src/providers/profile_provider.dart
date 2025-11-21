import 'package:flutter/foundation.dart';
import 'package:skating_routine_app/src/models/skating_element.dart';
import 'package:skating_routine_app/src/models/user.dart';
import 'package:skating_routine_app/src/services/firestore_service.dart';

class ProfileProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  User? _user;

  User? get user => _user;

  Future<void> loadProfile(String firebaseUid) async {
    _user = await _firestoreService.getUser(firebaseUid);
    if (_user == null) {
      final newUser = User(
        firebaseUid: firebaseUid,
        name: 'New Skater',
        level: SkatingLevel.prePreliminary,
        rotationDirection: RotationDirection.counterClockwise,
      );
      await _firestoreService.upsertUser(newUser);
      _user = newUser;
    }
    notifyListeners();
  }

  Future<void> updateProfile(User user) async {
    await _firestoreService.upsertUser(user);
    _user = user;
    notifyListeners();
  }

  void clearProfile() {
    _user = null;
    notifyListeners();
  }
}
