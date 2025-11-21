import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skating_routine_app/src/providers/routine_provider.dart';
import 'package:skating_routine_app/src/ui/widgets/rink_painter.dart';

class RoutineBuilderScreen extends StatefulWidget {
  const RoutineBuilderScreen({super.key});

  @override
  State<RoutineBuilderScreen> createState() => _RoutineBuilderScreenState();
}

class _RoutineBuilderScreenState extends State<RoutineBuilderScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routineProvider = Provider.of<RoutineProvider>(context);

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          routineProvider.saveActiveRoutine();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(routineProvider.activeRoutine?.name ?? 'New Routine'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search for elements...',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (query) {
                  routineProvider.searchElements(query);
                },
              ),
            ),
            if (routineProvider.searchResults.isNotEmpty)
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: routineProvider.searchResults.length,
                  itemBuilder: (context, index) {
                    final element = routineProvider.searchResults[index];
                    return ListTile(
                      title: Text(element.name),
                      onTap: () {
                        routineProvider.addElementToRoutine(element);
                        _searchController.clear();
                        routineProvider.searchElements('');
                      },
                    );
                  },
                ),
              ),
            const Divider(),
            Expanded(
              flex: 2,
              child: Consumer<RoutineProvider>(
                builder: (context, provider, child) {
                  if (provider.activeRoutine == null) {
                    return const Center(child: Text('No active routine.'));
                  }
                  return ReorderableListView.builder(
                    itemCount: provider.activeRoutine!.elements.length,
                    itemBuilder: (context, index) {
                      final element = provider.activeRoutine!.elements[index];
                      return ListTile(
                        key: ValueKey(element.id),
                        title: Text(element.name),
                        tileColor: provider.validationErrors.containsKey(index)
                            ? Colors.red.withAlpha((255 * 0.2).round())
                            : null,
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            provider.removeElementFromRoutine(index);
                          },
                        ),
                      );
                    },
                    onReorder: (oldIndex, newIndex) {
                      provider.reorderElement(oldIndex, newIndex);
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 200,
              child: CustomPaint(
                painter: RinkPainter(),
                child: const Center(child: Text('Rink Diagram Placeholder')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
