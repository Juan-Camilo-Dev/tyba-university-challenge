import '../../domain/entities/university.dart';

class UniversityModel extends University {
  const UniversityModel({
    required super.name,
    super.country,
    required super.alphaTwoCode,
    required super.domains,
    required super.webPages,
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      name: json['name'] ?? 'Unknown University',
      country: json['country'],
      alphaTwoCode: json['alpha_two_code'] ?? '',
      domains: List<String>.from(json['domains'] ?? []),
      webPages: List<String>.from(json['web_pages'] ?? []),
    );
  }
}