class Movie {
  int? id;
  String urlImage;
  String title;
  String actor;
  String ageGroup;
  String genre;
  String duration;
  String score;
  String description;
  String releaseYear;

  Movie({
    this.id,
    required this.urlImage,
    required this.title,
    required this.actor,
    required this.ageGroup,
    required this.genre,
    required this.duration,
    required this.score,
    required this.description,
    required this.releaseYear,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      urlImage: json['urlImage'],
      title: json['title'],
      actor: json['actor'],
      ageGroup: json['ageGroup'],
      genre: json['genre'],
      duration: json['duration'],
      score: json['score'],
      description: json['description'],
      releaseYear: json['releaseYear'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'urlImage': urlImage,
      'title': title,
      'actor': actor,
      'ageGroup': ageGroup,
      'genre': genre,
      'duration': duration,
      'score': score,
      'description': description,
      'releaseYear': releaseYear,
    };
  }
}
