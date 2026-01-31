import '../../core/usecases/usecase.dart'; // <--- Importamos la base
import '../entities/university.dart';
import '../repositories/university_repository.dart';

// Ahora implementamos UseCase<Retorno, Parametros>
class GetUniversities implements UseCase<List<University>, NoParams> {
  final UniversityRepository repository;

  GetUniversities(this.repository);

  @override
  Future<List<University>> call([NoParams? params]) async {
    return await repository.getUniversities();
  }
}