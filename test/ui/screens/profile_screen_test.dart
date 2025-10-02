import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:skating_routine_app/src/models/skating_element.dart';
import 'package:skating_routine_app/src/models/user.dart';
import 'package:skating_routine_app/src/providers/profile_provider.dart';
import 'package:skating_routine_app/src/ui/screens/profile_screen.dart';

import 'profile_screen_test.mocks.dart';

@GenerateMocks([ProfileProvider])
void main() {
  testWidgets(
    'ProfileScreen has dropdowns for level and direction',
    skip: true,
    (WidgetTester tester) async {
      // Create mock instance from the generated file
      final mockProvider = MockProfileProvider();

      // Create a default user to be returned by the mock
      final defaultUser = User(
        id: 1,
        name: 'Default User',
        level: SkatingLevel.preliminary,
        rotationDirection: RotationDirection.counterClockwise,
      );

      // Stub the user getter and methods
      when(mockProvider.user).thenReturn(defaultUser);
      when(mockProvider.loadProfile(any)).thenAnswer((_) async {});

      await tester.pumpWidget(
        ChangeNotifierProvider<ProfileProvider>.value(
          value: mockProvider,
          child: const MaterialApp(home: ProfileScreen()),
        ),
      );

      // The UI should now be built with the user data
      expect(find.text('Skating Level:'), findsOneWidget);
      expect(find.byType(DropdownButton<dynamic>), findsNWidgets(2));
      expect(find.text('Rotation Direction:'), findsOneWidget);
    },
  );
}
