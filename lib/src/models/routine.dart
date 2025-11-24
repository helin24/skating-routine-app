import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skating_routine_app/src/models/routine_element.dart';

class Routine {
  final String? id;
  final String userId;
  final String name;
  final List<RoutineElement> elements;

  Routine({
    this.id,
    required this.userId,
    required this.name,
    required this.elements,
  });

  factory Routine.fromMap(Map<String, dynamic> map) {
    return Routine(
      id: map['id'],
      userId: map['userId'],
      name: map['name'],
      elements: (map['elements'] as List)
          .map((e) => RoutineElement.fromMap(e))
          .toList(),
    );
  }

  factory Routine.fromFirestore(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return Routine(
      id: doc.id,
      userId: map['userId'],
      name: map['name'],
      elements: (map['elements'] as List)
          .map((e) => RoutineElement.fromMap(e))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'elements': elements.map((e) => e.toMap()).toList(),
    };
  }

  Routine copyWith({
    String? id,
    String? userId,
    String? name,
    List<RoutineElement>? elements,
  }) {
    return Routine(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      elements: elements ?? this.elements,
    );
  }
}
