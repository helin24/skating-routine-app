import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skating_routine_app/src/providers/profile_provider.dart';
import 'package:skating_routine_app/src/providers/routine_provider.dart';

class RoutineListScreen extends StatefulWidget {
  const RoutineListScreen({super.key});

  @override
  State<RoutineListScreen> createState() => _RoutineListScreenState();
}

class _RoutineListScreenState extends State<RoutineListScreen> {
  @override
  void initState() {
    super.initState();
    final user = Provider.of<ProfileProvider>(context, listen: false).currentUser;
    if (user != null) {
      Provider.of<RoutineProvider>(context, listen: false).loadRoutines(user.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final userName = profileProvider.currentUser?.name ?? 'Skater';

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
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/profile-selection');
          },
        ),
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
              return ListTile(
                title: Text(routine.name),
                subtitle: Text('${routine.elements.length} elements'),
                onTap: () {
                  Provider.of<RoutineProvider>(context, listen: false)
                      .setActiveRoutine(routine);
                  Navigator.pushNamed(context, '/routine-builder');
                },
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
