import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skating_routine_app/src/providers/profile_provider.dart';
import 'package:skating_routine_app/src/providers/routine_provider.dart';
import 'package:skating_routine_app/src/services/auth_service.dart';

class RoutineListScreen extends StatelessWidget {
  const RoutineListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final authService = Provider.of<AuthService>(context, listen: false);
    final userName = profileProvider.user?.name ?? 'Skater';

    return Scaffold(
      appBar: AppBar(
        title: Text('$userName\'s Routines'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authService.signOut();
            },
          ),
        ],
      ),
      body: Consumer<RoutineProvider>(
        builder: (context, provider, child) {
          if (provider.routines.isEmpty) {
            return const Center(child: Text('No routines found. Create one!'));
          }
          return ListView.builder(
            itemCount: provider.routines.length,
            itemBuilder: (context, index) {
              final routine = provider.routines[index];
              return Dismissible(
                key: Key(routine.id!),
                onDismissed: (direction) {
                  provider.deleteRoutine(routine.id!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${routine.name} deleted')),
                  );
                },
                background: Container(color: Colors.red),
                child: ListTile(
                  title: Text(routine.name),
                  subtitle: Text('${routine.elements.length} elements'),
                  onTap: () {
                    provider.setActiveRoutine(routine);
                    Navigator.pushNamed(context, '/routine-builder');
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<RoutineProvider>(context, listen: false).startNewRoutine();
          Navigator.pushNamed(context, '/routine-builder');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
