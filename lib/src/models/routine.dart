import 'skating_element.dart';

class Routine {
  final int id;
  final int userId;
  final String name;
  final List<SkatingElement> elements;

  Routine({
    required this.id,
    required this.userId,
    required this.name,
    required this.elements,
  });

  factory Routine.fromMap(Map<String, dynamic> map) {
    return Routine(
      id: map['id'],
      userId: map['userId'],
      name: map['name'],
      elements: [], // Elements will be fetched separately
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'userId': userId, 'name': name};
  }
}
