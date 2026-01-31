import '../entities/university.dart';
import '../repositories/university_repository.dart';

class GetUniversities {
  final UniversityRepository repository;

  GetUniversities(this.repository);

  Future<List<University>> call() async {
    return await repository.getUniversities();
  }
}