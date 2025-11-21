import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:skating_routine_app/src/models/routine.dart';
import 'package:skating_routine_app/src/models/skating_element.dart';
import 'package:skating_routine_app/src/providers/profile_provider.dart';
import 'package:skating_routine_app/src/services/database_helper.dart';
import 'package:skating_routine_app/src/services/firestore_service.dart';
import 'package:skating_routine_app/src/services/transition_validator.dart';

class RoutineProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final TransitionValidator _validator = TransitionValidator();
  ProfileProvider? _profileProvider;

  List<Routine> _routines = [];
  Routine? _activeRoutine;
  List<SkatingElement> _searchResults = [];
  final Map<int, bool> _validationErrors = {};
  StreamSubscription? _routinesSubscription;

  RoutineProvider();

  List<Routine> get routines => _routines;
  Routine? get activeRoutine => _activeRoutine;
  List<SkatingElement> get searchResults => _searchResults;
  Map<int, bool> get validationErrors => _validationErrors;

  void updateUser(ProfileProvider profileProvider) {
    if (_profileProvider?.user?.firebaseUid !=
        profileProvider.user?.firebaseUid) {
      _profileProvider = profileProvider;
      if (profileProvider.user != null) {
        _routinesSubscription?.cancel();
        _routinesSubscription = _firestoreService
            .getRoutines(profileProvider.user!.firebaseUid)
            .listen((routines) {
          _routines = routines;
          notifyListeners();
        });
      } else {
        _routinesSubscription?.cancel();
        _routines = [];
        notifyListeners();
      }
    }
  }

  Future<void> searchElements(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
    } else {
      _searchResults = await _dbHelper.searchElements(query);
    }
    notifyListeners();
  }

  void startNewRoutine(String name) {
    if (_profileProvider?.user == null) return;
    _activeRoutine = Routine(
      userId: _profileProvider!.user!.firebaseUid,
      name: name,
      elements: [],
    );
    notifyListeners();
  }

  void setActiveRoutine(Routine routine) {
    _activeRoutine = routine;
    _validateRoutine();
    notifyListeners();
  }

  void addElementToRoutine(SkatingElement element) {
    if (_activeRoutine != null) {
      _activeRoutine = _activeRoutine!.copyWith(
        elements: [..._activeRoutine!.elements, element],
      );
      _validateRoutine();
      notifyListeners();
    }
  }

  void removeElementFromRoutine(int index) {
    if (_activeRoutine != null) {
      final newElements = List<SkatingElement>.from(_activeRoutine!.elements)
        ..removeAt(index);
      _activeRoutine = _activeRoutine!.copyWith(elements: newElements);
      _validateRoutine();
      notifyListeners();
    }
  }

  void reorderElement(int oldIndex, int newIndex) {
    if (_activeRoutine != null) {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final newElements = List<SkatingElement>.from(_activeRoutine!.elements);
      final element = newElements.removeAt(oldIndex);
      newElements.insert(newIndex, element);
      _activeRoutine = _activeRoutine!.copyWith(elements: newElements);
      _validateRoutine();
      notifyListeners();
    }
  }

  void _validateRoutine() {
    _validationErrors.clear();
    if (_activeRoutine == null ||
        _activeRoutine!.elements.length < 2 ||
        _profileProvider?.user == null) {
      return;
    }

    final direction = _profileProvider!.user!.rotationDirection;

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
      await _firestoreService.upsertRoutine(_activeRoutine!);
    }
  }

  Future<void> deleteRoutine(String routineId) async {
    await _firestoreService.deleteRoutine(routineId);
  }

  @override
  void dispose() {
    _routinesSubscription?.cancel();
    super.dispose();
  }
}
