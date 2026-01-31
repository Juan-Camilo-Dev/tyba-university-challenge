import '../entities/university.dart';

abstract class UniversityRepository {
  Future<List<University>> getUniversities();
}