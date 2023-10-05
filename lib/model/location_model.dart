class LocationModel {
  final String city;

  LocationModel({
    required this.city,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      city: json['ageRating'] ?? '',
    );
  }
}