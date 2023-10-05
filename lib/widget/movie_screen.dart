import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:vaganza_movie/common/styles.dart';
import 'package:vaganza_movie/model/playing_model.dart';
import 'package:vaganza_movie/model/upcoming_model.dart';
import 'package:vaganza_movie/ui/playing_detail_page.dart';
import 'package:vaganza_movie/ui/upcoming_detail_page.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  static const String routeName = '/movie_screen';

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final CollectionReference _play = FirebaseFirestore.instance.collection("play");
  final CollectionReference _upcoming = FirebaseFirestore.instance.collection("upcoming");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          title: const Text("Film Bioskop", style: TextStyle(color: secondaryColor)),
          elevation: 1,
          backgroundColor: primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: secondaryColor),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      backgroundColor: primaryColor,
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: "Sedang Tayang"),
                Tab(text: "Akan Datang"),
              ],
              unselectedLabelColor: secondaryColor,
              labelColor: secondaryColor,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  StreamBuilder(
                    stream: _play.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        return ListView.builder(
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                            final model = PlayingModel(
                              ageRating: documentSnapshot['ageRating'],
                              director: documentSnapshot['director'],
                              duration: documentSnapshot['duration'],
                              genre: documentSnapshot['genre'],
                              image: documentSnapshot['image'],
                              movieRating: documentSnapshot['movieRating'],
                              name: documentSnapshot['name'],
                              synopsis: documentSnapshot['synopsis'],
                            );
                            return Card(
                              elevation: 0,
                              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8), // Margin
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PlayingDetailPage(playingModel: model),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child:  Image.network(
                                          model.image,
                                          width: 100,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(model.name),
                                          Row(
                                            children: [
                                              Card(
                                                color: Colors.grey,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    model.ageRating,
                                                    style: const TextStyle(color: Colors.white, fontSize: 8),
                                                  ),
                                                ),
                                              ),
                                              Text(model.genre),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              RatingBar.builder(
                                                initialRating: (double.tryParse(model.movieRating) ?? 0.0) / 2.0,
                                                minRating: 0.5,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 15.0,
                                                itemBuilder: (context, _) {
                                                  return const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  );
                                                },
                                                onRatingUpdate: (rating) {
                                                  // Tidak perlu melakukan apa-apa karena ini hanya tampilan
                                                },
                                                updateOnDrag: false,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(model.movieRating, style: const TextStyle(fontSize: 10)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else if(streamSnapshot.hasError){
                        return const Text('404 Data Not Found');
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  StreamBuilder(
                    stream: _upcoming.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        return ListView.builder(
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                            final model = UpcomingModel(
                              ageRating: documentSnapshot['ageRating'],
                              director: documentSnapshot['director'],
                              duration: documentSnapshot['duration'],
                              genre: documentSnapshot['genre'],
                              image: documentSnapshot['image'],
                              name: documentSnapshot['name'],
                              synopsis: documentSnapshot['synopsis'],
                            );
                            return Card(
                              elevation: 0,
                              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8), // Margin
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UpcomingDetailPage(upcomingModel: model),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child:  Image.network(
                                          model.image,
                                          width: 100,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(model.name),
                                          Card(
                                            color: Colors.grey,
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                model.ageRating,
                                                style: const TextStyle(color: Colors.white, fontSize: 8),
                                              ),
                                            ),
                                          ),
                                          Text(model.genre),
                                          const SizedBox(height: 8),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else if(streamSnapshot.hasError){
                        return const Text('404 Data Not Found');
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
