import 'package:flutter/material.dart';
import '../../domain/entities/university.dart';
import '../../domain/usecases/get_universities.dart';

class UniversityProvider extends ChangeNotifier {
  final GetUniversities getUniversities;

  UniversityProvider({required this.getUniversities});

  // Estados
  bool isLoading = false;
  String? errorMessage;

  // Listas para el manejo de datos y scroll infinito
  List<University> _allUniversities = []; // Toda la data del JSON
  List<University> displayedUniversities = []; // Lo que se ve en pantalla

  // Configuración de visualización
  bool isGridView = false;
  int _currentPage = 0;
  final int _pageSize = 20; // Requerimiento del bono: cargar cada 20

  // Método inicial para cargar datos
  Future<void> loadUniversities() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      _allUniversities = await getUniversities();
      _currentPage = 0;
      displayedUniversities = [];
      _loadNextPage(); // Carga los primeros 20
    } catch (e) {
      errorMessage = "No se pudieron cargar las universidades. Revisa tu conexión.";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Lógica del Infinite Scroll (Bono)
  void loadMore() {
    if (displayedUniversities.length < _allUniversities.length) {
      _loadNextPage();
      notifyListeners();
    }
  }

  void _loadNextPage() {
    final nextCount = (_currentPage + 1) * _pageSize;
    final totalCount = _allUniversities.length;

    // Calculamos el corte seguro para no salirnos del rango
    final end = nextCount < totalCount ? nextCount : totalCount;

    displayedUniversities = _allUniversities.sublist(0, end);
    _currentPage++;
  }

  // Cambiar Layout (ListView <-> GridView)
  void toggleViewMode() {
    isGridView = !isGridView;
    notifyListeners();
  }

  // Actualizar una universidad (Imagen o Estudiantes)
  void updateUniversity(University updatedUniversity) {
    // 1. Actualizar en la lista maestra
    final indexInAll = _allUniversities.indexWhere((u) => u.name == updatedUniversity.name);
    if (indexInAll != -1) {
      _allUniversities[indexInAll] = updatedUniversity;
    }

    // 2. Actualizar en la lista visible
    final indexInDisplayed = displayedUniversities.indexWhere((u) => u.name == updatedUniversity.name);
    if (indexInDisplayed != -1) {
      displayedUniversities[indexInDisplayed] = updatedUniversity;
      notifyListeners();
    }
  }
}