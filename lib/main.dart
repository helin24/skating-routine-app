import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skating_routine_app/src/providers/profile_provider.dart';
import 'package:skating_routine_app/src/providers/routine_provider.dart';
import 'package:skating_routine_app/src/services/auth_service.dart';
import 'package:skating_routine_app/src/ui/screens/login_screen.dart';
import 'package:skating_routine_app/src/ui/screens/profile_screen.dart';
import 'package:skating_routine_app/src/ui/screens/routine_builder_screen.dart';
import 'package:skating_routine_app/src/ui/screens/routine_list_screen.dart';
import 'package:skating_routine_app/src/ui/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProxyProvider<ProfileProvider, RoutineProvider>(
          create: (context) => RoutineProvider(),
          update: (context, profileProvider, previous) {
            previous?.updateUser(profileProvider);
            return previous!;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Skating Routine App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const AuthWrapper(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignUpScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/routine-list': (context) => const RoutineListScreen(),
          '/routine-builder': (context) => const RoutineBuilderScreen(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final User? user = snapshot.data;
        if (user == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (profileProvider.user != null) {
              profileProvider.clearProfile();
            }
          });
          return const LoginScreen();
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (profileProvider.user?.firebaseUid != user.uid) {
              profileProvider.loadProfile(user.uid);
            }
          });
          return const RoutineListScreen();
        }
      },
    );
  }
}
