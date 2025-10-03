import 'package:flutter/foundation.dart';
import 'package:skating_routine_app/src/models/routine.dart';
import 'package:skating_routine_app/src/models/skating_element.dart';
import 'package:skating_routine_app/src/services/database_helper.dart';
import 'package:skating_routine_app/src/services/transition_validator.dart';

class RoutineProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final TransitionValidator _validator = TransitionValidator();
  List<Routine> _routines = [];
  Routine? _activeRoutine;
  List<SkatingElement> _searchResults = [];
  final Map<int, bool> _validationErrors = {};

  List<Routine> get routines => _routines;
  Routine? get activeRoutine => _activeRoutine;
  List<SkatingElement> get searchResults => _searchResults;
  Map<int, bool> get validationErrors => _validationErrors;

  Future<void> searchElements(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
    } else {
      _searchResults = await _dbHelper.searchElements(query);
    }
    notifyListeners();
  }

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
      _validateRoutine();
      notifyListeners();
    }
  }

  void removeElementFromRoutine(int index) {
    if (_activeRoutine != null) {
      _activeRoutine!.elements.removeAt(index);
      _validateRoutine();
      notifyListeners();
    }
  }

  void reorderElement(int oldIndex, int newIndex) {
    if (_activeRoutine != null) {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final element = _activeRoutine!.elements.removeAt(oldIndex);
      _activeRoutine!.elements.insert(newIndex, element);
      _validateRoutine();
      notifyListeners();
    }
  }

  void _validateRoutine() {
    _validationErrors.clear();
    if (_activeRoutine == null || _activeRoutine!.elements.length < 2) {
      return;
    }

    // TODO: Get user from ProfileProvider instead of hardcoding.
    const direction = RotationDirection.counterClockwise;

    for (int i = 0; i < _activeRoutine!.elements.length - 1; i++) {
      final current = _activeRoutine!.elements[i];
      final next = _activeRoutine!.elements[i + 1];
      if (!_validator.canConnect(current, next, direction)) {
        _validationErrors[i] = false;
      }
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
