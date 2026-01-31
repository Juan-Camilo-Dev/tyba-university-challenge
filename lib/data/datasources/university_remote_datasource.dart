import 'package:dio/dio.dart';
import '../models/university_model.dart';

abstract class UniversityRemoteDataSource {
  Future<List<UniversityModel>> getUniversities();
}

class UniversityRemoteDataSourceImpl implements UniversityRemoteDataSource {
  final Dio dio;

  UniversityRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<UniversityModel>> getUniversities() async {
    try {
      final response = await dio.get('https://tyba-assets.s3.amazonaws.com/FE-Engineer-test/universities.json');

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