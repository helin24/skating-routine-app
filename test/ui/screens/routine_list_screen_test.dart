import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:skating_routine_app/src/providers/routine_provider.dart';
import 'package:skating_routine_app/src/ui/screens/routine_list_screen.dart';

import 'routine_list_screen_test.mocks.dart';

@GenerateMocks([RoutineProvider])
void main() {
  testWidgets('RoutineListScreen has an app bar and floating action button', (
    WidgetTester tester,
  ) async {
    // Create mock instance
    final mockProvider = MockRoutineProvider();

    // Stub the routines getter to return an empty list
    when(mockProvider.routines).thenReturn([]);

    await tester.pumpWidget(
      ChangeNotifierProvider<RoutineProvider>.value(
        value: mockProvider,
        child: const MaterialApp(home: RoutineListScreen()),
      ),
    );

    expect(find.text('My Routines'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    // Since the list is empty, we expect to find the placeholder text.
    expect(find.text('No routines found. Create one!'), findsOneWidget);
  });
}
