import 'package:flutter/material.dart';
import 'package:vaganza_movie/ui/home_page.dart';
import 'package:vaganza_movie/model/upcoming_model.dart';
import 'package:vaganza_movie/widget/favorite_button.dart';

var fontStyle = const TextStyle(fontFamily: "fonts/RobotoCondensed-Bold.ttf");

class UpcomingDetailPage extends StatefulWidget {
  final UpcomingModel place;

  const UpcomingDetailPage({Key? key, required this.place}) : super(key: key);

  @override
  State<UpcomingDetailPage> createState() => _UpcomingDetailPageState();
}

class _UpcomingDetailPageState extends State<UpcomingDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
        automaticallyImplyLeading: false,
        title: Center(
          child: Image.asset('assets/logo.png', width: 180, height: 50),
        ),
        backgroundColor: const Color(0xFFFFFFFF),
      ),
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
                      child: Image.asset(widget.place.imageAsset,
                          width: 350, height: 499),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Text(
                          widget.place.name,
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
                          children: <Widget>[
                            const SizedBox(width: 8),
                            Text(
                              "Genre:\n${widget.place.genre}",
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
                          "Durasi:\n${widget.place.duration}",
                          style: fontStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        const SizedBox(width: 8),
                        Text(
                          "Sutradara:\n${widget.place.direction}",
                          style: fontStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        const SizedBox(width: 8),
                        Text(
                          "Rating Usia:\n${widget.place.ageRating}",
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
                        widget.place.synopsis,
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
