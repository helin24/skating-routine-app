import 'package:flutter/foundation.dart';
import 'package:skating_routine_app/src/models/skating_element.dart';
import 'package:skating_routine_app/src/services/firestore_service.dart';

class ElementProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<SkatingElement> _elements = [];

  List<SkatingElement> get elements => _elements;

  Future<void> loadElements() async {
    _elements = await _firestoreService.getSkatingElements();
    notifyListeners();
  }
}
