import 'package:skating_routine_app/src/models/skating_element.dart';

// Represents a specific instance of a skating element within a routine.
class RoutineElement {
  // The code of the base element, e.g., "3T" for a three-turn or "A" for an Axel.
  final String baseElementCode;
  final String name; // The display name, e.g., "RFI Three-Turn" or "Axel"
  final ElementType type;

  // The actual, concrete entry and exit for this specific instance in the routine.
  final Foot entryFoot;
  final Edge entryEdge;
  final Foot exitFoot;
  final Edge exitEdge;

  final bool isToeAssist;

  RoutineElement({
    required this.baseElementCode,
    required this.name,
    required this.type,
    required this.entryFoot,
    required this.entryEdge,
    required this.exitFoot,
    required this.exitEdge,
    required this.isToeAssist,
  });

  factory RoutineElement.fromMap(Map<String, dynamic> map) {
    return RoutineElement(
      baseElementCode: map['baseElementCode'] ?? '',
      name: map['name'] ?? '',
      type: ElementType.values
          .firstWhere((e) => e.toString() == (map['type'] ?? 'ElementType.jump')),
      entryFoot: Foot.values.firstWhere(
          (e) => e.toString() == (map['entryFoot'] ?? 'Foot.left')),
      entryEdge: Edge.values.firstWhere(
          (e) => e.toString() == (map['entryEdge'] ?? 'Edge.outside')),
      exitFoot: Foot.values
          .firstWhere((e) => e.toString() == (map['exitFoot'] ?? 'Foot.right')),
      exitEdge: Edge.values.firstWhere(
          (e) => e.toString() == (map['exitEdge'] ?? 'Edge.outside')),
      isToeAssist: (map['isToeAssist'] is int)
          ? map['isToeAssist'] == 1
          : map['isToeAssist'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'baseElementCode': baseElementCode,
      'name': name,
      'type': type.toString(),
      'entryFoot': entryFoot.toString(),
      'entryEdge': entryEdge.toString(),
      'exitFoot': exitFoot.toString(),
      'exitEdge': exitEdge.toString(),
      'isToeAssist': isToeAssist,
    };
  }
}
