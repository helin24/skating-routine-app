import 'package:skating_routine_app/src/models/skating_element.dart';

class User {
  int? id;
  final String name;
  final SkatingLevel level;
  final RotationDirection rotationDirection;

  User({
    this.id,
    required this.name,
    required this.level,
    required this.rotationDirection,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      level: SkatingLevel.values
          .firstWhere((e) => e.toString() == map['level']),
      rotationDirection: RotationDirection.values
          .firstWhere((e) => e.toString() == map['rotationDirection']),
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'level': level.toString(),
      'rotationDirection': rotationDirection.toString(),
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
