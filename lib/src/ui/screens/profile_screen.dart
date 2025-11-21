import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skating_routine_app/src/models/skating_element.dart';
import 'package:skating_routine_app/src/models/user.dart';
import 'package:skating_routine_app/src/providers/profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: Consumer<ProfileProvider>(
        builder: (context, provider, child) {
          if (provider.user == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Skating Level:', style: TextStyle(fontSize: 18)),
                DropdownButton<SkatingLevel>(
                  value: provider.user!.level,
                  onChanged: (SkatingLevel? newValue) {
                    if (newValue != null) {
                      final updatedUser = User(
                        id: provider.user!.id,
                        firebaseUid: provider.user!.firebaseUid,
                        name: provider.user!.name,
                        level: newValue,
                        rotationDirection:
                            provider.user!.rotationDirection,
                      );
                      provider.updateProfile(updatedUser);
                    }
                  },
                  items: SkatingLevel.values.map((SkatingLevel level) {
                    return DropdownMenuItem<SkatingLevel>(
                      value: level,
                      child: Text(level.toString().split('.').last),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Rotation Direction:',
                  style: TextStyle(fontSize: 18),
                ),
                DropdownButton<RotationDirection>(
                  value: provider.user!.rotationDirection,
                  onChanged: (RotationDirection? newValue) {
                    if (newValue != null) {
                      final updatedUser = User(
                        id: provider.user!.id,
                        firebaseUid: provider.user!.firebaseUid,
                        name: provider.user!.name,
                        level: provider.user!.level,
                        rotationDirection: newValue,
                      );
                      provider.updateProfile(updatedUser);
                    }
                  },
                  items: RotationDirection.values.map((
                    RotationDirection direction,
                  ) {
                    return DropdownMenuItem<RotationDirection>(
                      value: direction,
                      child: Text(direction.toString().split('.').last),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
