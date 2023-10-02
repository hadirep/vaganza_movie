class MovieModel {
  final String ageRating;
  final String director;
  final String duration;
  final String genre;
  final String image;
  final dynamic movieRating;
  final String name;
  final String synopsis;

  MovieModel({
    required this.ageRating,
    required this.director,
    required this.duration,
    required this.genre,
    required this.image,
    required this.movieRating,
    required this.name,
    required this.synopsis,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      ageRating: json['ageRating'] ?? '',
      director: json['director'] ?? '',
      duration: json['duration'] ?? '',
      genre: json['genre'] ?? '',
      image: json['image'] ?? '',
      movieRating: json['movieRating'] ?? 0,
      name: json['name'] ?? '',
      synopsis: json['synopsis'] ?? '',
    );
  }
}