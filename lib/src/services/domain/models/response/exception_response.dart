class ExceptionResponse {
  final String message;
  final int statusCode;

  ExceptionResponse({required this.message, required this.statusCode});
}

class PokemonException {
  final String message;

  PokemonException({required this.message});
}
