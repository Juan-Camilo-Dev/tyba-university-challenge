import 'package:equatable/equatable.dart';

class University extends Equatable {
  final String name;
  final String? country; // Puede ser null
  final String alphaTwoCode;
  final List<String> domains;
  final List<String> webPages;
  // Campos extra
  final String? imagePath;
  final int? studentCount;

  const University({
    required this.name,
    this.country,
    required this.alphaTwoCode,
    required this.domains,
    required this.webPages,
    this.imagePath,
    this.studentCount,
  });

  // Método para crear una copia modificada (Para actualizar imagen y/o estudiantes)
  University copyWith({
    String? name,
    String? country,
    String? alphaTwoCode,
    List<String>? domains,
    List<String>? webPages,
    String? imagePath,
    int? studentCount,
  }) {
    return University(
      name: name ?? this.name,
      country: country ?? this.country,
      alphaTwoCode: alphaTwoCode ?? this.alphaTwoCode,
      domains: domains ?? this.domains,
      webPages: webPages ?? this.webPages,
      imagePath: imagePath ?? this.imagePath,
      studentCount: studentCount ?? this.studentCount,
    );
  }

  @override
  List<Object?> get props => [name, country, alphaTwoCode, domains, webPages, imagePath, studentCount];
}