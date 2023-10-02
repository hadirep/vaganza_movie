import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vaganza_movie/model/movie_model.dart';
import 'package:vaganza_movie/ui/upcoming_detail_page.dart';

class UpcomingListPage extends StatefulWidget {
  const UpcomingListPage({Key? key}) : super(key: key);

  @override
  State<UpcomingListPage> createState() => _UpcomingListPageState();
}

class _UpcomingListPageState extends State<UpcomingListPage> {
  final CollectionReference _upcoming = FirebaseFirestore.instance.collection('upcoming');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Image.asset('assets/logo.png', width: 180, height: 50),
        ),
        backgroundColor: const Color(0xFFFFFFFF),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.only(left: 16),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "AKAN DATANG",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "fonts/RobotoCondensed-Bold.ttf",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 5),
            StreamBuilder(
              stream: _upcoming.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.1),
                    ),
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                      final model = MovieModel(
                        ageRating: documentSnapshot['ageRating'],
                        director: documentSnapshot['director'],
                        duration: documentSnapshot['duration'],
                        genre: documentSnapshot['genre'],
                        image: documentSnapshot['image'],
                        movieRating: documentSnapshot['movieRating'],
                        name: documentSnapshot['name'],
                        synopsis: documentSnapshot['synopsis'],
                      );
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpcomingDetailPage(upcomingModel: model),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      model.image,
                                      width: 175,
                                      height: 250,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      model.name,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily:
                                          "fonts/RobotoCondensed-Bold.ttf",
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(color: Colors.red),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
