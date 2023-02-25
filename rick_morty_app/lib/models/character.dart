class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final CharLocation origin;
  final CharLocation location;
  final String created;
  final String url;
  final List<String> episode;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.origin,
    required this.location,
    required this.created,
    required this.url,
    required this.episode,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      origin: CharLocation.fromJson(json['origin']),
      location: CharLocation.fromJson(json['location']),
      image: json['image'],
      episode: List<String>.from(json['episode']),
      url: json['url'],
      created: json['created'],
    );
  }
}

class CharLocation {
  final String name;
  final String url;

  CharLocation({required this.name, required this.url});

  factory CharLocation.fromJson(Map<String, dynamic> json) {
    return CharLocation(
      name: json['name'],
      url: json['url'],
    );
  }
}
