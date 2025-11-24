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

enum ElementType { jump, spin, stepSequence, turn }

// Defines the transformation rule for a turn.
class TurnDetails {
  final bool changesFoot;
  final bool changesDirection; // e.g., forward to backward
  final bool changesEdge;

  TurnDetails({
    required this.changesFoot,
    required this.changesDirection,
    required this.changesEdge,
  });

  factory TurnDetails.fromMap(Map<String, dynamic> map) {
    return TurnDetails(
      changesFoot: map['changesFoot'],
      changesDirection: map['changesDirection'],
      changesEdge: map['changesEdge'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'changesFoot': changesFoot,
      'changesDirection': changesDirection,
      'changesEdge': changesEdge,
    };
  }
}

// Represents the definition of a skating element.
class SkatingElement {
  final String name;
  final String code; // e.g., "3T" for three-turn, "A" for Axel
  final ElementType type;
  final SkatingLevel minLevel;

  // For non-turn elements, these define the static entry/exit.
  // For turns, these will be null.
  final Edge? entryEdge;
  final Foot? entryFoot;
  final bool isToeAssist;
  final Edge? exitEdge;
  final Foot? exitFoot;

  // Details for how a turn transforms the skater's state.
  final TurnDetails? turnDetails;

  bool get isTurn => type == ElementType.turn;

  SkatingElement({
    required this.name,
    required this.code,
    required this.type,
    required this.minLevel,
    this.entryEdge,
    this.entryFoot,
    this.isToeAssist = false,
    this.exitEdge,
    this.exitFoot,
    this.turnDetails,
  });

  factory SkatingElement.fromMap(Map<String, dynamic> map) {
    return SkatingElement(
      name: map['name'],
      code: map['code'],
      type: ElementType.values.firstWhere((e) => e.toString() == map['type']),
      minLevel: SkatingLevel.values
          .firstWhere((e) => e.toString() == map['minLevel']),
      entryEdge: map['entryEdge'] != null
          ? Edge.values.firstWhere((e) => e.toString() == map['entryEdge'])
          : null,
      entryFoot: map['entryFoot'] != null
          ? Foot.values.firstWhere((e) => e.toString() == map['entryFoot'])
          : null,
      isToeAssist: (map['isToeAssist'] is int)
          ? map['isToeAssist'] == 1
          : map['isToeAssist'] ?? false,
      exitEdge: map['exitEdge'] != null
          ? Edge.values.firstWhere((e) => e.toString() == map['exitEdge'])
          : null,
      exitFoot: map['exitFoot'] != null
          ? Foot.values.firstWhere((e) => e.toString() == map['exitFoot'])
          : null,
      turnDetails: map['turnDetails'] != null
          ? TurnDetails.fromMap(map['turnDetails'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
      'type': type.toString(),
      'minLevel': minLevel.toString(),
      'entryEdge': entryEdge?.toString(),
      'entryFoot': entryFoot?.toString(),
      'isToeAssist': isToeAssist,
      'exitEdge': exitEdge?.toString(),
      'exitFoot': exitFoot?.toString(),
      'turnDetails': turnDetails?.toMap(),
    };
  }
}
