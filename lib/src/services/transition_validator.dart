import 'package:skating_routine_app/src/models/routine_element.dart';
import 'package:skating_routine_app/src/models/skating_element.dart';

class TransitionValidator {
  // A simple rule-based validator. In a real app, this could be much more complex.
  bool canConnect(
    RoutineElement from,
    RoutineElement to,
    RotationDirection rotationDirection,
  ) {
    // For now, we'll use a simple rule: the entry foot of the next element
    // must match the exit foot of the previous element.
    if (from.exitFoot != to.entryFoot) {
      return false;
    }

    // A common transition: Axel (LFO exit) -> Toe Loop (RTO entry)
    // This is a special case where the foot changes.
    if (from.baseElementCode == 'A' && to.baseElementCode == 'T') {
      return true;
    }

    // By default, allow transitions if the feet match.
    // This is a simplification and would be expanded in a real app.
    return true;
  }
}
