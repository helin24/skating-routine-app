import 'package:flutter_test/flutter_test.dart';
import 'package:skating_routine_app/src/models/skating_element.dart';
import 'package:skating_routine_app/src/services/transition_validator.dart';

void main() {
  group('TransitionValidator', () {
    late TransitionValidator validator;

    setUp(() {
      validator = TransitionValidator();
    });

    test('returns true for valid known transition', () {
      final previous = SkatingElement(
        name: 'Axel',
        code: 'A',
        type: ElementType.jump,
        minLevel: SkatingLevel.preBronze,
        entryEdge: Edge.outside,
        entryFoot: Foot.left,
        isToeAssist: false,
        exitEdge: Edge.outside,
        exitFoot: Foot.right,
      );

      final next = SkatingElement(
        name: 'Toe Loop',
        code: 'T',
        type: ElementType.jump,
        minLevel: SkatingLevel.prePreliminary,
        entryEdge: Edge.outside,
        entryFoot: Foot.right,
        isToeAssist: true,
        exitEdge: Edge.outside,
        exitFoot: Foot.right,
      );

      final result = validator.canConnect(
        previous,
        next,
        RotationDirection.counterClockwise,
      );
      expect(result, isTrue);
    });

    test('returns true by default for unknown transitions', () {
      final previous = SkatingElement(
        name: 'Lutz',
        code: 'Lz',
        type: ElementType.jump,
        minLevel: SkatingLevel.preBronze,
        entryEdge: Edge.outside,
        entryFoot: Foot.left,
        isToeAssist: true,
        exitEdge: Edge.outside,
        exitFoot: Foot.right,
      );

      final next = SkatingElement(
        name: 'Salchow',
        code: 'S',
        type: ElementType.jump,
        minLevel: SkatingLevel.prePreliminary,
        entryEdge: Edge.inside,
        entryFoot: Foot.left,
        isToeAssist: false,
        exitEdge: Edge.outside,
        exitFoot: Foot.right,
      );

      final result = validator.canConnect(
        previous,
        next,
        RotationDirection.counterClockwise,
      );
      expect(result, isTrue);
    });
  });
}
