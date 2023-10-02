import 'package:flutter/material.dart';
import 'package:vaganza_movie/model/movie_model.dart';
import 'package:vaganza_movie/widget/favorite_button.dart';

var fontStyle = const TextStyle(fontFamily: "fonts/RobotoCondensed-Bold.ttf");

class PlayingDetailPage extends StatefulWidget {
  static const String routeName = 'vaganza_playing_page';
  final MovieModel playingModel;

  const PlayingDetailPage({Key? key, required this.playingModel}) : super(key: key);

  @override
  State<PlayingDetailPage> createState() => _PlayingDetailPageState();
}

class _PlayingDetailPageState extends State<PlayingDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 8,
        ),
        child: ListView(
          children: <Widget>[
            Card(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.playingModel.image,
                        width: 350, height: 499,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Text(
                          widget.playingModel.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 8),
                            Text(
                              "Genre:\n${widget.playingModel.genre}",
                              style: fontStyle,
                            ),
                          ],
                        ),
                        const FavoriteButton(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        const SizedBox(width: 8),
                        Text(
                          "Durasi:\n${widget.playingModel.duration}",
                          style: fontStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        const SizedBox(width: 8),
                        Text(
                          "Sutradara:\n${widget.playingModel.director}",
                          style: fontStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        const SizedBox(width: 8),
                        Text(
                          "Rating Usia:\n${widget.playingModel.ageRating}",
                          style: fontStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        const SizedBox(width: 8),
                        Text(
                          "Rating Film:\n${widget.playingModel.movieRating}",
                          style: fontStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "SINOPSIS",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        widget.playingModel.synopsis,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
