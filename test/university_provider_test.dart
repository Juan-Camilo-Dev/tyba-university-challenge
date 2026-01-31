import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tyba_university_explorer/domain/entities/university.dart';
import 'package:tyba_university_explorer/domain/usecases/get_universities.dart';
import 'package:tyba_university_explorer/presentation/providers/university_provider.dart';

// 1. Creamos un Mock (un imitador) del Caso de Uso
class MockGetUniversities extends Mock implements GetUniversities {}

void main() {
  late UniversityProvider provider;
  late MockGetUniversities mockGetUniversities;

  setUp(() {
    mockGetUniversities = MockGetUniversities();
    provider = UniversityProvider(getUniversities: mockGetUniversities);
  });

  // Datos de prueba falsos
  final tUniversities = [
    const University(
      name: "Test Uni 1",
      alphaTwoCode: "US",
      domains: ["test.edu"],
      webPages: ["http://test.edu"],
      country: "US",
    ),
    const University(
      name: "Test Uni 2",
      alphaTwoCode: "CO",
      domains: ["test.co"],
      webPages: ["http://test.co"],
      country: "CO",
    ),
  ];

  group('UniversityProvider Test', () {
    test('El estado inicial debe ser correcto', () {
      expect(provider.isLoading, false);
      expect(provider.displayedUniversities, isEmpty);
      expect(provider.errorMessage, null);
    });

    test('Debe cargar universidades correctamente', () async {
      // ARRANGE: Enseñamos al imitador qué responder
      when(() => mockGetUniversities()).thenAnswer((_) async => tUniversities);

      // ACT: Ejecutamos la función
      final future = provider.loadUniversities();

      // ASSERT: Verificamos que isLoading sea true mientras carga
      expect(provider.isLoading, true);

      await future;

      // ASSERT: Verificamos el resultado final
      expect(provider.isLoading, false);
      expect(provider.displayedUniversities.length, 2); // Esperamos 2 ítems (los 20 se cortan solo si hay más)
      expect(provider.errorMessage, null);
    });

    test('Debe manejar errores correctamente', () async {
      // ARRANGE: Simulamos un error
      when(() => mockGetUniversities()).thenThrow(Exception('Error de red'));

      // ACT
      await provider.loadUniversities();

      // ASSERT
      expect(provider.isLoading, false);
      expect(provider.displayedUniversities, isEmpty);
      expect(provider.errorMessage, isNotNull);
    });
  });
}