class PokemonList {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonEntry> results;

  PokemonList({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PokemonList.fromJson(Map<String, dynamic> json) {
    final results = (json['results'] as List)
        .map((pokemon) => PokemonEntry.fromJson(pokemon))
        .toList();

    return PokemonList(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: results,
    );
  }
}

class PokemonEntry {
  final String name;
  final String url;

  PokemonEntry({required this.name, required this.url});

  factory PokemonEntry.fromJson(Map<String, dynamic> json) {
    return PokemonEntry(
      name: json['name'],
      url: json['url'],
    );
  }
}
