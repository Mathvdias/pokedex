class ApiURL {
  static final ApiURL _instance = ApiURL._();
  ApiURL._();
  static ApiURL get instance => _instance;

  base<String>() => url;

  static const url = "https://pokeapi.co/api/v2";
}

