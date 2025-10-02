import 'package:skating_routine_app/src/models/skating_element.dart';

class TransitionValidator {
  // A simple rule-based validator for element transitions.
  // This will be expanded with more complex rules.
  bool canConnect(
    SkatingElement previous,
    SkatingElement next,
    RotationDirection direction,
  ) {
    // Example rule based on user feedback:
    // If a skater lands backwards on their left leg, a reasonable connecting element
    // could be a right forward outside three turn, but not a left forward outside three turn.

    // This is a simplified implementation of that rule.
    // A full implementation would require a comprehensive map of all transitions.
    if (direction == RotationDirection.counterClockwise) {
      if (previous.exitFoot == Foot.right &&
          previous.exitEdge == Edge.outside) {
        // After landing a standard CCW jump, what comes next?
        // A right forward outside three-turn is a common entry to a flip jump.
        if (next.name == 'Flip' &&
            next.entryFoot == Foot.left &&
            next.entryEdge == Edge.inside) {
          return true;
        }
        // A toe loop can be done from a right back outside edge.
        if (next.name == 'Toe Loop' &&
            next.entryFoot == Foot.right &&
            next.entryEdge == Edge.outside) {
          return true;
        }
      }
    }

    // Default to true for now if no specific rule applies.
    // In a full implementation, this would likely default to false.
    return true;
  }
}
