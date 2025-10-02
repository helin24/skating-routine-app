import 'package:flutter/foundation.dart';
import 'package:skating_routine_app/src/models/routine.dart';
import 'package:skating_routine_app/src/models/skating_element.dart';
import 'package:skating_routine_app/src/services/database_helper.dart';

class RoutineProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Routine> _routines = [];
  Routine? _activeRoutine;

  List<Routine> get routines => _routines;
  Routine? get activeRoutine => _activeRoutine;

  Future<void> loadRoutines(int userId) async {
    _routines = await _dbHelper.getRoutinesForUser(userId);
    notifyListeners();
  }

  void setActiveRoutine(Routine routine) {
    _activeRoutine = routine;
    notifyListeners();
  }

  void addElementToRoutine(SkatingElement element) {
    if (_activeRoutine != null) {
      _activeRoutine!.elements.add(element);
      notifyListeners();
    }
  }

  void removeElementFromRoutine(int index) {
    if (_activeRoutine != null) {
      _activeRoutine!.elements.removeAt(index);
      notifyListeners();
    }
  }

  Future<void> saveActiveRoutine() async {
    if (_activeRoutine != null) {
      await _dbHelper.insertRoutine(_activeRoutine!);
      // Reload routines to get the updated list
      await loadRoutines(_activeRoutine!.userId);
    }
  }
}
