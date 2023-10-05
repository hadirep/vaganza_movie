import 'package:cloud_firestore/cloud_firestore.dart';

class PlayingModel {
  final String ageRating;
  final String director;
  final String duration;
  final String genre;
  final String image;
  final String movieRating;
  final String name;
  final String synopsis;

  PlayingModel({
    required this.ageRating,
    required this.director,
    required this.duration,
    required this.genre,
    required this.image,
    required this.movieRating,
    required this.name,
    required this.synopsis,
  });

  factory PlayingModel.fromJson(Map<String, dynamic> json) {
    return PlayingModel(
      ageRating: json['ageRating'] ?? '',
      director: json['director'] ?? '',
      duration: json['duration'] ?? '',
      genre: json['genre'] ?? '',
      image: json['image'] ?? '',
      movieRating: json['movieRating'] ?? '',
      name: json['name'] ?? '',
      synopsis: json['synopsis'] ?? '',
    );
  }

  factory PlayingModel.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return PlayingModel(
      ageRating: data['ageRating'] ?? '',
      director: data['director'] ?? '',
      duration: data['duration'] ?? '',
      genre: data['genre'] ?? '',
      image: data['image'] ?? '',
      movieRating: data['movieRating'] ?? '',
      name: data['name'] ?? '',
      synopsis: data['synopsis'] ?? '',
    );
  }
}