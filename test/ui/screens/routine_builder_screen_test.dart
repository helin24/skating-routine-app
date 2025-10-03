import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:skating_routine_app/src/models/routine.dart';
import 'package:skating_routine_app/src/providers/routine_provider.dart';
import 'package:skating_routine_app/src/ui/screens/routine_builder_screen.dart';

import 'routine_builder_screen_test.mocks.dart';

@GenerateMocks([RoutineProvider])
void main() {
  testWidgets('RoutineBuilderScreen builds without crashing', (
    WidgetTester tester,
  ) async {
    final mockProvider = MockRoutineProvider();

    when(
      mockProvider.activeRoutine,
    ).thenReturn(Routine(id: 1, userId: 1, name: 'Test Routine', elements: []));
    when(mockProvider.searchResults).thenReturn([]);
    when(mockProvider.validationErrors).thenReturn({});

    await tester.pumpWidget(
      ChangeNotifierProvider<RoutineProvider>.value(
        value: mockProvider,
        child: const MaterialApp(home: RoutineBuilderScreen()),
      ),
    );

    expect(find.text('Test Routine'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });
}
