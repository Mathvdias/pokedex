import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/src/app/service/models/pokemom_model.dart';
import 'package:pokedex/src/app/service/providers/http_client_interface.dart';
import 'package:pokedex/src/app/service/repository/impl/pokemon_repository.dart';
import 'package:pokedex/src/app/viewmodels/pokemon_viewmodel.dart';

class PokemonRepositoryMock implements PokemonRepository {
  @override
  IRestClient get client => throw UnimplementedError();

  @override
  Future<PokemonModel> getPokemons(1) async {
    return PokemonModel(
        id: 1, name: "Matheus", sprite: "wather", type1: "Top", type2: "Sim");
  }
}

class PokemonRepositoryErrorMock implements PokemonRepository {
  @override
  IRestClient get client => throw UnimplementedError();

  @override
  Future<PokemonModel> getPokemons() async {
    return PokemonModel();
  }
}

class PokemonClientHttpMockito extends Mock implements PokemonRepository {}

void main() {
  final mock = PokemonRepositoryMock();
  final mockError = PokemonClientHttpMockito();
  group('Test', () {
    test('PokemomRepository: id is 1', () async {
      final viewModel = PokemonViewModel(mock);
      await viewModel.fetchAll();
      expect(viewModel.pokemonModel.id, 1);
    });
    test('PokemomRepository: name is Matheus', () async {
      final viewModel = PokemonViewModel(mock);
      await viewModel.fetchAll();
      expect(viewModel.pokemonModel.name, 'Matheus');
    });
    test('PokemomRepository: sprite is wather', () async {
      final viewModel = PokemonViewModel(mock);
      await viewModel.fetchAll();
      expect(viewModel.pokemonModel.sprite, 'wather');
    });
    test('PokemomRepository: success', () async {
      final viewModel = PokemonViewModel(mockError);
      await viewModel.fetchAll();
      expect(viewModel.pokemonModel, isA<PokemonModel>());
    });

    test('PokemomRepository: error', () async {
      final viewModel = PokemonViewModel(mockError);
      await viewModel.fetchAll();
      expect(viewModel.pokemonModel.sprite, null);
    });
  });
}
