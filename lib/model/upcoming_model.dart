import 'package:cloud_firestore/cloud_firestore.dart';

class UpcomingModel {
  final String ageRating;
  final String director;
  final String duration;
  final String genre;
  final String image;
  final String name;
  final String synopsis;

  UpcomingModel({
    required this.ageRating,
    required this.director,
    required this.duration,
    required this.genre,
    required this.image,
    required this.name,
    required this.synopsis,
  });

  factory UpcomingModel.fromJson(Map<String, dynamic> json) {
    return UpcomingModel(
      ageRating: json['ageRating'] ?? '',
      director: json['director'] ?? '',
      duration: json['duration'] ?? '',
      genre: json['genre'] ?? '',
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      synopsis: json['synopsis'] ?? '',
    );
  }

  factory UpcomingModel.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UpcomingModel(
      ageRating: data['ageRating'] ?? '',
      director: data['director'] ?? '',
      duration: data['duration'] ?? '',
      genre: data['genre'] ?? '',
      image: data['image'] ?? '',
      name: data['name'] ?? '',
      synopsis: data['synopsis'] ?? '',
    );
  }
}