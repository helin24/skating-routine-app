enum SkatingLevel {
  prePreliminary,
  preliminary,
  preBronze,
  bronze,
  preSilver,
  silver,
  preGold,
  gold,
}

enum RotationDirection { clockwise, counterClockwise }

enum Edge { inside, outside, flat }

enum Foot { left, right }

enum ElementType { jump, spin, stepSequence }

class SkatingElement {
  final int? id;
  final String name;
  final String code; // e.g., "1A" for single Axel
  final ElementType type;
  final SkatingLevel minLevel;

  // Properties for transition validation
  final Edge entryEdge;
  final Foot entryFoot;
  final bool isToeAssist;
  final Edge exitEdge;
  final Foot exitFoot;

  SkatingElement({
    this.id,
    required this.name,
    required this.code,
    required this.type,
    required this.minLevel,
    required this.entryEdge,
    required this.entryFoot,
    required this.isToeAssist,
    required this.exitEdge,
    required this.exitFoot,
  });

  factory SkatingElement.fromMap(Map<String, dynamic> map) {
    return SkatingElement(
      id: map['id'],
      name: map['name'],
      code: map['code'],
      type: ElementType.values.firstWhere((e) => e.toString() == map['type']),
      minLevel: SkatingLevel.values.firstWhere(
        (e) => e.toString() == map['minLevel'],
      ),
      entryEdge: Edge.values.firstWhere(
        (e) => e.toString() == map['entryEdge'],
      ),
      entryFoot: Foot.values.firstWhere(
        (e) => e.toString() == map['entryFoot'],
      ),
      isToeAssist: map['isToeAssist'] == 1,
      exitEdge: Edge.values.firstWhere((e) => e.toString() == map['exitEdge']),
      exitFoot: Foot.values.firstWhere((e) => e.toString() == map['exitFoot']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'type': type.toString(),
      'minLevel': minLevel.toString(),
      'entryEdge': entryEdge.toString(),
      'entryFoot': entryFoot.toString(),
      'isToeAssist': isToeAssist ? 1 : 0,
      'exitEdge': exitEdge.toString(),
      'exitFoot': exitFoot.toString(),
    };
  }
}
