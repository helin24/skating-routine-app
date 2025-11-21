import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skating_routine_app/src/models/routine.dart';
import 'package:skating_routine_app/src/models/skating_element.dart';
import 'package:skating_routine_app/src/models/user.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // User methods
  Future<void> upsertUser(User user) {
    return _db.collection('users').doc(user.firebaseUid).set(user.toMap());
  }

  Future<User?> getUser(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (doc.exists) {
      return User.fromMap(doc.data()!);
    }
    return null;
  }

  // Routine methods
  Future<void> upsertRoutine(Routine routine) {
    if (routine.id == null) {
      final docRef = _db.collection('routines').doc();
      final newRoutine = routine.copyWith(id: docRef.id);
      return docRef.set(newRoutine.toMap());
    } else {
      return _db.collection('routines').doc(routine.id).set(routine.toMap());
    }
  }

  Stream<List<Routine>> getRoutines(String userId) {
    return _db
        .collection('routines')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Routine.fromFirestore(doc)).toList());
  }

  Future<void> deleteRoutine(String routineId) {
    return _db.collection('routines').doc(routineId).delete();
  }

  // Skating Element methods
  Future<List<SkatingElement>> getSkatingElements() async {
    final snapshot = await _db.collection('skating_elements').get();
    return snapshot.docs
        .map((doc) => SkatingElement.fromMap(doc.data()))
        .toList();
  }
}
