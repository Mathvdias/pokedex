import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/src/app/service/models/pokemom_model.dart';
import 'package:pokedex/src/app/service/providers/http_client_interface.dart';
import 'package:pokedex/src/app/service/repository/impl/pokemon_repository.dart';
import 'package:pokedex/src/app/viewmodels/pokemon_viewmodel.dart';

class ClientHttpMock implements IRestClient {
  @override
  Future get(String url) async {
    return PokemonModel(name: "matheus", url: "pokebola.com").toJson();
  }
}

void main() {
  test('PokemomRepository: success', () async {
    final viewModel = PokemonViewModel(PokemonRepository(ClientHttpMock()));
    await viewModel.fetchAll();
    expect(viewModel.pokemonModel, isA<PokemonModel>());
  });
}
