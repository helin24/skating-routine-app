import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skating_routine_app/src/providers/profile_provider.dart';
import 'package:skating_routine_app/src/providers/routine_provider.dart';
import 'package:skating_routine_app/src/ui/screens/profile_screen.dart';
import 'package:skating_routine_app/src/ui/screens/routine_list_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => RoutineProvider()),
      ],
      child: MaterialApp(
        title: 'Skating Routine App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const RoutineListScreen(),
        routes: {'/profile': (context) => const ProfileScreen()},
      ),
    );
  }
}
