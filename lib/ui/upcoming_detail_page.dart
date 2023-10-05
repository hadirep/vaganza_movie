import 'package:flutter/material.dart';
import 'package:vaganza_movie/common/styles.dart';
import 'package:vaganza_movie/model/upcoming_model.dart';

class UpcomingDetailPage extends StatelessWidget {
  final UpcomingModel upcomingModel;
  const UpcomingDetailPage({Key? key, required this.upcomingModel}) : super(key: key);

  static const String routeName = 'upcoming_detail_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          elevation: 1,
          title: Center(
            child: Text(
              upcomingModel.name,
              style: const TextStyle(color: secondaryColor),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                upcomingModel.image,
                height: 300,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              upcomingModel.name,
              textAlign: TextAlign.center,
              style: myTextTheme.titleLarge,
            ),
            Text(
              "Genre:\n${upcomingModel.genre}",
              style: myTextTheme.titleSmall,
            ),
            const SizedBox(height: 10),
            Text(
              "Durasi:\n${upcomingModel.duration}",
              style: myTextTheme.titleSmall,
            ),
            const SizedBox(height: 10),
            Text(
              "Sutradara:\n${upcomingModel.director}",
              style: myTextTheme.titleSmall,
            ),
            const SizedBox(height: 10),
            Text(
              "Rating Usia:\n${upcomingModel.ageRating}",
              style: myTextTheme.titleSmall,
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                "SINOPSIS",
                style: myTextTheme.titleMedium,
              ),
            ),
            Text(
              upcomingModel.synopsis,
              textAlign: TextAlign.justify,
              style: myTextTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
