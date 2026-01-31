import '../../domain/entities/university.dart';
import '../../domain/repositories/university_repository.dart';
import '../datasources/university_remote_datasource.dart';

class UniversityRepositoryImpl implements UniversityRepository {
  final UniversityRemoteDataSource remoteDataSource;

  UniversityRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<University>> getUniversities() async {
    return await remoteDataSource.getUniversities();
  }
}