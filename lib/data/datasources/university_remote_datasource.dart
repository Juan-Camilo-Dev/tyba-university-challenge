import 'package:dio/dio.dart';
import '../models/university_model.dart';
import '../../core/constants/api_constants.dart';

abstract class UniversityRemoteDataSource {
  Future<List<UniversityModel>> getUniversities();
}

class UniversityRemoteDataSourceImpl implements UniversityRemoteDataSource {
  final Dio dio;

  UniversityRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<UniversityModel>> getUniversities() async {
    try {
      // Usamos la constante en lugar de un String directo
      final response = await dio.get(ApiConstants.universitiesUrl);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => UniversityModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load universities');
      }
    } catch (e) {
      throw Exception('Network Error: $e');
    }
  }
}