import 'skating_element.dart';

class Routine {
  int? id;
  final int userId;
  final String name;
  final List<SkatingElement> elements;

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
      elements: [], // Elements will be fetched separately
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'userId': userId,
      'name': name,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
