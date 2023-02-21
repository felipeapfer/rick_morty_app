class Episode {
  final int id;
  final String name;
  final String air_date;
  final String episode;
  final String created;
  final String url;
  final List<String> characters;

  Episode({
    required this.id,
    required this.name,
    required this.air_date,
    required this.episode,
    required this.created,
    required this.url,
    required this.characters,
  });
}
