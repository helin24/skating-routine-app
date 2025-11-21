import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skating_routine_app/src/models/skating_element.dart';

class User {
  final String firebaseUid;
  final String name;
  final SkatingLevel level;
  final RotationDirection rotationDirection;

  User({
    required this.firebaseUid,
    required this.name,
    required this.level,
    required this.rotationDirection,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firebaseUid: map['firebaseUid'],
      name: map['name'],
      level: SkatingLevel.values
          .firstWhere((e) => e.toString() == map['level']),
      rotationDirection: RotationDirection.values
          .firstWhere((e) => e.toString() == map['rotationDirection']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firebaseUid': firebaseUid,
      'name': name,
      'level': level.toString(),
      'rotationDirection': rotationDirection.toString(),
    };
  }

  User copyWith({
    String? firebaseUid,
    String? name,
    SkatingLevel? level,
    RotationDirection? rotationDirection,
  }) {
    return User(
      firebaseUid: firebaseUid ?? this.firebaseUid,
      name: name ?? this.name,
      level: level ?? this.level,
      rotationDirection: rotationDirection ?? this.rotationDirection,
    );
  }
}
