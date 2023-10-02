import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vaganza_movie/common/styles.dart';
import 'package:vaganza_movie/data/service/auth_service.dart';
import 'package:vaganza_movie/ui/login_page.dart';
import 'package:vaganza_movie/ui/playing_detail_page.dart'; // Import halaman detail
import 'package:vaganza_movie/model/movie_model.dart'; // Import kelas model

class PlayingListPage extends StatefulWidget {
  const PlayingListPage({Key? key}) : super(key: key);

  static const routeName = '/playing_list_page';

  @override
  State<PlayingListPage> createState() => _PlayingListPageState();
}

class _PlayingListPageState extends State<PlayingListPage> {
  final CollectionReference _rating = FirebaseFirestore.instance.collection('rating');
  final CollectionReference _play = FirebaseFirestore.instance.collection('play');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset('assets/logo.png', width: 180, height: 50),
        ),
        backgroundColor: const Color(0xFFFFFFFF),
        leading: Padding(
          padding: const EdgeInsets.symmetric(),
          child: Builder(
            builder: (context) => IconButton(
              icon: Image.asset(
                'assets/icon.png',
                height: 50,
                width: 50,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/logo.png',
                  width: 200,
                  height: 50,
                ),
              ),
              const Divider(color: secondaryColor),
              ListTile(
                title: const Text(
                  "Logout",
                  style: TextStyle(color: secondaryColor, fontSize: 15),
                ),
                trailing: const Icon(Icons.logout, color: secondaryColor),
                onTap: () async {
                  final navigator = Navigator.of(context);
                  await AuthService().logOut();
                  navigator.pushReplacementNamed(LoginPage.routeName);
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.only(left: 16),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "RATING TERTINGGI",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "fonts/RobotoCondensed-Bold.ttf",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            StreamBuilder(
              stream: _rating.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return SizedBox(
                    height: 200.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
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
                                builder: (context) => PlayingDetailPage(playingModel: model),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: Image.network(
                                          model.image, // Gunakan image dari playModel
                                          width: 145,
                                          height: 165,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              model.name, // Gunakan name dari playModel
                                              style: const TextStyle(
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(color: Colors.red),
                );
              },
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.only(left: 16),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "SEDANG TAYANG",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "fonts/RobotoCondensed-Bold.ttf",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            StreamBuilder(
              stream: _play.snapshots(),
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
                              builder: (context) => PlayingDetailPage(playingModel: model),
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