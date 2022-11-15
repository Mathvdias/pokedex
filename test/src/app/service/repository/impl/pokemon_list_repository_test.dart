import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/src/app/service/providers/impl/dio_client_provider.dart';
import 'package:pokedex/src/app/service/repository/impl/pokemon_list_repository.dart';

void main() {
  test('Lista de pokemons', () async {
    final json = PokemonListRepository(DioClient.withAuthBasic());
    await json.getAllPokemons("50");
    expect(json, isA<PokemonListRepository>()); 
  });
}
