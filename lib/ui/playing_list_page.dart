import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vaganza_movie/common/styles.dart';
import 'package:vaganza_movie/model/play_model.dart';
import 'package:vaganza_movie/model/rating_model.dart';
import 'package:vaganza_movie/ui/login_page.dart';
import 'package:vaganza_movie/ui/playing_detail_page.dart';
import 'package:vaganza_movie/ui/rating_detail_page.dart';

class PlayingListPage extends StatefulWidget {
  const PlayingListPage({Key? key}) : super(key: key);

  static const routeName = '/vaganza_list_page';

  @override
  State<PlayingListPage> createState() => _PlayingListPageState();
}

class _PlayingListPageState extends State<PlayingListPage> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                  await _auth.signOut();

                  navigator.pushReplacementNamed(LoginPage.routeName);
                },
              ),
            ],
          ),
        ),
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
                  "RATING TERTINGGI",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "fonts/RobotoCondensed-Bold.ttf",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 200.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final RatingModel rating = ratingModel[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RatingDetailPage(place: rating),
                                ),
                              );
                            },
                            child: Column(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Card(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          child: Image.asset(rating.imageAsset,
                                              width: 145, height: 165),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                rating.name,
                                                style: const TextStyle(
                                                    fontSize: 10.0,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                        itemCount: ratingModel.length,
                      ),
                    ),
                  ],
                ),
              ],
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
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.1),
              ),
              itemCount: playModel.length,
              itemBuilder: (context, index) {
                PlayModel place = playModel[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayingDetailPage(place: place),
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
                              child: Image.asset(
                                place.imageAsset,
                                width: 175,
                                height: 250,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 5,
                              ),
                              child: Text(
                                place.name,
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
            ),
          ],
        ),
      ),
    );
  }
}
