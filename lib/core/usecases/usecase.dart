// Type: Lo que devuelve el caso de uso, ejemplo: List<University>)
// Params: Los parámetros que necesita, ejemplo: int id, String search
abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

// Clase auxiliar para cuando un caso de uso no necesita parámetros
class NoParams {}