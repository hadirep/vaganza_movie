import 'package:flutter/material.dart';
import 'package:vaganza_movie/common/styles.dart';
import 'package:vaganza_movie/model/playing_model.dart';

class PlayingDetailPage extends StatelessWidget {
  final PlayingModel playingModel;
  const PlayingDetailPage({Key? key, required this.playingModel}) : super(key: key);

  static const String routeName = 'playing_detail_page';

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
              playingModel.name,
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
                playingModel.image,
                height: 300,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              playingModel.name,
              textAlign: TextAlign.center,
              style: myTextTheme.titleLarge,
            ),
            Text(
              "Genre:\n${playingModel.genre}",
              style: myTextTheme.titleSmall,
            ),
            const SizedBox(height: 10),
            Text(
              "Durasi:\n${playingModel.duration}",
              style: myTextTheme.titleSmall,
            ),
            const SizedBox(height: 10),
            Text(
              "Sutradara:\n${playingModel.director}",
              style: myTextTheme.titleSmall,
            ),
            const SizedBox(height: 10),
            Text(
              "Rating Usia:\n${playingModel.ageRating}",
              style: myTextTheme.titleSmall,
            ),
            const SizedBox(height: 10),
            Text(
              "Rating Film:\n${playingModel.movieRating}",
              style:  myTextTheme.titleSmall,
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                "SINOPSIS",
                style: myTextTheme.titleMedium,
              ),
            ),
            Text(
                playingModel.synopsis,
                textAlign: TextAlign.justify,
                style: myTextTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
