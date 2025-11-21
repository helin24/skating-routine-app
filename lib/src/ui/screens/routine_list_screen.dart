import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skating_routine_app/src/providers/routine_provider.dart';

class RoutineListScreen extends StatelessWidget {
  const RoutineListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Routines'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
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
          Provider.of<RoutineProvider>(context, listen: false)
              .startNewRoutine();
          Navigator.pushNamed(context, '/routine-builder');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
