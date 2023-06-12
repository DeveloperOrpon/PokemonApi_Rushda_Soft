class PokemonDetail {
  final int id;
  final String name;
  final int baseExperience;
  final int height;
  final int weight;
  final List<PokemonType> types;

  PokemonDetail({
    required this.id,
    required this.name,
    required this.baseExperience,
    required this.height,
    required this.weight,
    required this.types,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    final types = (json['types'] as List)
        .map((type) => PokemonType.fromJson(type['type']))
        .toList();

    return PokemonDetail(
      id: json['id'],
      name: json['name'],
      baseExperience: json['base_experience'],
      height: json['height'],
      weight: json['weight'],
      types: types,
    );
  }
}

class PokemonType {
  final String name;

  PokemonType({required this.name});

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    return PokemonType(
      name: json['name'],
    );
  }
}
