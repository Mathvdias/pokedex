class PokemonDetailStatsModel {
  PokemonDetailStatsModel({
    this.abilities,
    this.height,
    this.id,
    this.moves,
    this.name,
    this.order,
    this.sprite,
    this.stats,
    this.types,
    this.type1 = '',
    this.type2 = '',
    this.weight,
  });

  PokemonDetailStatsModel.fromJson(Map<String, dynamic> json) {
    if (json['abilities'] != null) {
      abilities = <Abilities>[];
      json['abilities'].forEach((v) {
        abilities!.add(Abilities.fromJson(v));
      });
    }
    baseExperience = json['base_experience'];

    height = json['height'] ?? "";

    id = json['id'];

    if (json['moves'] != null) {
      moves = <Moves>[];
      json['moves'].forEach((v) {
        moves!.add(Moves.fromJson(v));
      });
    }
    name = json['name'];
    order = json['order'];

    sprite = json['sprites']['other']['official-artwork']['front_default'];
    if (json['stats'] != null) {
      stats = <Stats>[];
      json['stats'].forEach((v) {
        stats!.add(Stats.fromJson(v));
      });
    }
    types = json['types'];
    type1 = json['types'][0]['type']['name'] ?? "";
    type2 = types?.length == 2 ? json['types'][1]['type']['name'] : null;
    weight = json['weight'] ?? "";
  }

  List<Abilities>? abilities;
  int? baseExperience;
  int? height;
  int? id;
  bool? isDefault;
  String? locationAreaEncounters;
  List<Moves>? moves;
  String? name;
  int? order;
  String? sprite;
  List<Stats>? stats;
  List? types;
  String? type1;
  String? type2;
  int? weight;
}

class Abilities {
  Abilities({this.ability, this.isHidden, this.slot});

  Abilities.fromJson(Map<String, dynamic> json) {
    ability =
        json['ability'] != null ? Ability.fromJson(json['ability']) : null;
    isHidden = json['is_hidden'];
    slot = json['slot'];
  }

  Ability? ability;
  bool? isHidden;
  int? slot;
}

class Ability {
  Ability({this.name, this.url});

  Ability.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    url = json['url'] ?? '';
  }

  String? name;
  String? url;
}

class GameIndices {
  GameIndices({this.gameIndex, this.version});

  GameIndices.fromJson(Map<String, dynamic> json) {
    gameIndex = json['game_index'];
    version =
        json['version'] != null ? Ability.fromJson(json['version']) : null;
  }

  int? gameIndex;
  Ability? version;
}

class Moves {
  Moves({this.move, this.versionGroupDetails});

  Moves.fromJson(Map<String, dynamic> json) {
    move = json['move'] != null ? Ability.fromJson(json['move']) : null;
    if (json['version_group_details'] != null) {
      versionGroupDetails = <VersionGroupDetails>[];
      json['version_group_details'].forEach((v) {
        versionGroupDetails!.add(VersionGroupDetails.fromJson(v));
      });
    }
  }

  Ability? move;
  List<VersionGroupDetails>? versionGroupDetails;
}

class VersionGroupDetails {
  VersionGroupDetails(
      {this.levelLearnedAt, this.moveLearnMethod, this.versionGroup});

  VersionGroupDetails.fromJson(Map<String, dynamic> json) {
    levelLearnedAt = json['level_learned_at'];
    moveLearnMethod = json['move_learn_method'] != null
        ? Ability.fromJson(json['move_learn_method'])
        : null;
    versionGroup = json['version_group'] != null
        ? Ability.fromJson(json['version_group'])
        : null;
  }

  int? levelLearnedAt;
  Ability? moveLearnMethod;
  Ability? versionGroup;
}

class Sprites {
  Sprites(
      {this.backDefault,
      this.backShiny,
      this.frontDefault,
      this.frontShiny,
      this.other,
      this.versions});

  Sprites.fromJson(Map<String, dynamic> json) {
    backDefault = json['back_default'];

    backShiny = json['back_shiny'];

    frontDefault = json['front_default'];

    frontShiny = json['front_shiny'];

    other = json['other'] != null ? Other.fromJson(json['other']) : null;
  }

  String? backDefault;
  String? backShiny;
  String? frontDefault;
  String? frontShiny;
  Other? other;
  Versions? versions;
}

class Other {
  Other({this.dreamWorld, this.home, this.officialArtwork});

  Other.fromJson(Map<String, dynamic> json) {
    dreamWorld = json['dream_world'] != null
        ? DreamWorld.fromJson(json['dream_world'])
        : null;
    home = json['home'] != null ? Home.fromJson(json['home']) : null;
    officialArtwork = json['official-artwork'] != null
        ? OfficialArtwork.fromJson(json['official-artwork'])
        : null;
  }

  DreamWorld? dreamWorld;
  Home? home;
  OfficialArtwork? officialArtwork;
}

class DreamWorld {
  DreamWorld({this.frontDefault});

  DreamWorld.fromJson(Map<String, dynamic> json) {
    frontDefault = json['front_default'];
  }

  String? frontDefault;
}

class Home {
  Home({
    this.frontDefault,
    this.frontShiny,
  });

  Home.fromJson(Map<String, dynamic> json) {
    frontDefault = json['front_default'];

    frontShiny = json['front_shiny'];
  }

  String? frontDefault;
  String? frontShiny;
}

class OfficialArtwork {
  OfficialArtwork({this.frontDefault});

  OfficialArtwork.fromJson(Map<String, dynamic> json) {
    frontDefault = json['front_default'];
  }

  String? frontDefault;
}

class Versions {
  Versions(
      {this.generationI,
      this.generationIi,
      this.generationIii,
      this.generationIv,
      this.generationV,
      this.generationVi,
      this.generationVii,
      this.generationViii});

  GenerationI? generationI;
  GenerationIi? generationIi;
  GenerationIii? generationIii;
  GenerationIv? generationIv;
  GenerationV? generationV;
  GenerationVi? generationVi;
  GenerationVii? generationVii;
  GenerationViii? generationViii;
}

class GenerationI {
  GenerationI({this.redBlue, this.yellow});

  GenerationI.fromJson(Map<String, dynamic> json) {
    redBlue =
        json['red-blue'] != null ? RedBlue.fromJson(json['red-blue']) : null;
    yellow = json['yellow'] != null ? RedBlue.fromJson(json['yellow']) : null;
  }

  RedBlue? redBlue;
  RedBlue? yellow;
}

class RedBlue {
  RedBlue(
      {this.backDefault,
      this.backGray,
      this.backTransparent,
      this.frontDefault,
      this.frontGray,
      this.frontTransparent});

  RedBlue.fromJson(Map<String, dynamic> json) {
    backDefault = json['back_default'];
    backGray = json['back_gray'];
    backTransparent = json['back_transparent'];
    frontDefault = json['front_default'];
    frontGray = json['front_gray'];
    frontTransparent = json['front_transparent'];
  }

  String? backDefault;
  String? backGray;
  String? backTransparent;
  String? frontDefault;
  String? frontGray;
  String? frontTransparent;
}

class GenerationIi {
  GenerationIi({this.crystal, this.gold, this.silver});

  GenerationIi.fromJson(Map<String, dynamic> json) {
    crystal =
        json['crystal'] != null ? Crystal.fromJson(json['crystal']) : null;
    gold = json['gold'] != null ? Gold.fromJson(json['gold']) : null;
    silver = json['silver'] != null ? Gold.fromJson(json['silver']) : null;
  }

  Crystal? crystal;
  Gold? gold;
  Gold? silver;
}

class Crystal {
  Crystal(
      {this.backDefault,
      this.backShiny,
      this.backShinyTransparent,
      this.backTransparent,
      this.frontDefault,
      this.frontShiny,
      this.frontShinyTransparent,
      this.frontTransparent});

  Crystal.fromJson(Map<String, dynamic> json) {
    backDefault = json['back_default'];
    backShiny = json['back_shiny'];
    backShinyTransparent = json['back_shiny_transparent'];
    backTransparent = json['back_transparent'];
    frontDefault = json['front_default'];
    frontShiny = json['front_shiny'];
    frontShinyTransparent = json['front_shiny_transparent'];
    frontTransparent = json['front_transparent'];
  }

  String? backDefault;
  String? backShiny;
  String? backShinyTransparent;
  String? backTransparent;
  String? frontDefault;
  String? frontShiny;
  String? frontShinyTransparent;
  String? frontTransparent;
}

class Gold {
  Gold(
      {this.backDefault,
      this.backShiny,
      this.frontDefault,
      this.frontShiny,
      this.frontTransparent});

  Gold.fromJson(Map<String, dynamic> json) {
    backDefault = json['back_default'];
    backShiny = json['back_shiny'];
    frontDefault = json['front_default'];
    frontShiny = json['front_shiny'];
    frontTransparent = json['front_transparent'];
  }

  String? backDefault;
  String? backShiny;
  String? frontDefault;
  String? frontShiny;
  String? frontTransparent;
}

class GenerationIii {
  GenerationIii({this.emerald, this.fireredLeafgreen, this.rubySapphire});

  GenerationIii.fromJson(Map<String, dynamic> json) {
    emerald =
        json['emerald'] != null ? Emerald.fromJson(json['emerald']) : null;
    fireredLeafgreen = json['firered-leafgreen'] != null
        ? FireredLeafgreen.fromJson(json['firered-leafgreen'])
        : null;
    rubySapphire = json['ruby-sapphire'] != null
        ? FireredLeafgreen.fromJson(json['ruby-sapphire'])
        : null;
  }

  Emerald? emerald;
  FireredLeafgreen? fireredLeafgreen;
  FireredLeafgreen? rubySapphire;
}

class Emerald {
  Emerald({this.frontDefault, this.frontShiny});

  Emerald.fromJson(Map<String, dynamic> json) {
    frontDefault = json['front_default'];
    frontShiny = json['front_shiny'];
  }

  String? frontDefault;
  String? frontShiny;
}

class FireredLeafgreen {
  FireredLeafgreen(
      {this.backDefault, this.backShiny, this.frontDefault, this.frontShiny});

  FireredLeafgreen.fromJson(Map<String, dynamic> json) {
    backDefault = json['back_default'];
    backShiny = json['back_shiny'];
    frontDefault = json['front_default'];
    frontShiny = json['front_shiny'];
  }

  String? backDefault;
  String? backShiny;
  String? frontDefault;
  String? frontShiny;
}

class GenerationIv {
  GenerationIv({this.diamondPearl, this.heartgoldSoulsilver, this.platinum});

  GenerationIv.fromJson(Map<String, dynamic> json) {
    diamondPearl = json['diamond-pearl'] != null
        ? DiamondPearl.fromJson(json['diamond-pearl'])
        : null;
    heartgoldSoulsilver = json['heartgold-soulsilver'] != null
        ? DiamondPearl.fromJson(json['heartgold-soulsilver'])
        : null;
    platinum = json['platinum'] != null
        ? DiamondPearl.fromJson(json['platinum'])
        : null;
  }

  DiamondPearl? diamondPearl;
  DiamondPearl? heartgoldSoulsilver;
  DiamondPearl? platinum;
}

class DiamondPearl {
  DiamondPearl({
    this.backDefault,
    this.backShiny,
    this.frontDefault,
    this.frontShiny,
  });

  DiamondPearl.fromJson(Map<String, dynamic> json) {
    backDefault = json['back_default'];

    backShiny = json['back_shiny'];

    frontDefault = json['front_default'];

    frontShiny = json['front_shiny'];
  }

  String? backDefault;
  String? backShiny;
  String? frontDefault;
  String? frontShiny;
}

class GenerationV {
  GenerationV({this.blackWhite});

  GenerationV.fromJson(Map<String, dynamic> json) {
    blackWhite = json['black-white'] != null
        ? BlackWhite.fromJson(json['black-white'])
        : null;
  }

  BlackWhite? blackWhite;
}

class BlackWhite {
  BlackWhite({
    this.animated,
    this.backDefault,
    this.backShiny,
    this.frontDefault,
    this.frontShiny,
  });

  BlackWhite.fromJson(Map<String, dynamic> json) {
    animated = json['animated'] != null
        ? DiamondPearl.fromJson(json['animated'])
        : null;
    backDefault = json['back_default'];

    backShiny = json['back_shiny'];

    frontDefault = json['front_default'];

    frontShiny = json['front_shiny'];
  }

  DiamondPearl? animated;
  String? backDefault;
  String? backShiny;
  String? frontDefault;
  String? frontShiny;
}

class GenerationVi {
  GenerationVi({this.omegarubyAlphasapphire, this.xY});

  GenerationVi.fromJson(Map<String, dynamic> json) {
    omegarubyAlphasapphire = json['omegaruby-alphasapphire'] != null
        ? Home.fromJson(json['omegaruby-alphasapphire'])
        : null;
    xY = json['x-y'] != null ? Home.fromJson(json['x-y']) : null;
  }

  Home? omegarubyAlphasapphire;
  Home? xY;
}

class GenerationVii {
  GenerationVii({this.icons, this.ultraSunUltraMoon});

  GenerationVii.fromJson(Map<String, dynamic> json) {
    icons = json['icons'] != null ? DreamWorld.fromJson(json['icons']) : null;
    ultraSunUltraMoon = json['ultra-sun-ultra-moon'] != null
        ? Home.fromJson(json['ultra-sun-ultra-moon'])
        : null;
  }

  DreamWorld? icons;
  Home? ultraSunUltraMoon;
}

class GenerationViii {
  GenerationViii({this.icons});

  GenerationViii.fromJson(Map<String, dynamic> json) {
    icons = json['icons'] != null ? DreamWorld.fromJson(json['icons']) : null;
  }

  DreamWorld? icons;
}

class Stats {
  Stats({this.baseStat, this.effort, this.stat});

  Stats.fromJson(Map<String, dynamic> json) {
    baseStat = json['base_stat'];
    effort = json['effort'];
    stat = json['stat'] != null ? Ability.fromJson(json['stat']) : null;
  }

  int? baseStat;
  int? effort;
  Ability? stat;
}
