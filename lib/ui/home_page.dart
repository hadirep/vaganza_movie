import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vaganza_movie/common/styles.dart';
import 'package:vaganza_movie/data/service/auth_service.dart';
import 'package:vaganza_movie/model/upcoming_model.dart';
import 'package:vaganza_movie/ui/account_page.dart';
import 'package:vaganza_movie/ui/login_page.dart';
import 'package:vaganza_movie/ui/playing_detail_page.dart';
import 'package:vaganza_movie/model/playing_model.dart';
import 'package:vaganza_movie/ui/upcoming_detail_page.dart';
import 'package:vaganza_movie/widget/widget_location.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:vaganza_movie/widget/movie_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/playing_list_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = 'JAKARTA';
  final authService = AuthService();
  final CollectionReference _play = FirebaseFirestore.instance.collection('play');
  final CollectionReference _upcoming = FirebaseFirestore.instance.collection('upcoming');

  List<CarouselItem> itemList = [
    CarouselItem(
      image: const NetworkImage(
        "https://bit.ly/image_slider_1"
      ),
    ),
    CarouselItem(
      image: const NetworkImage(
        "https://bit.ly/image_slider_2",
      ),
    ),
    CarouselItem(
      image: const NetworkImage(
        "https://bit.ly/image_slider_3",
      ),
    ),
  ];

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
            child: Image.asset(
              'assets/logo.png',
              width: 180,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                if (authService.isUserLoggedIn()) {
                  // Jika pengguna sudah login, navigasikan ke halaman AccountPage
                  Navigator.pushNamed(context, AccountPage.routeName);
                } else {
                  // Jika pengguna belum login, navigasikan ke halaman LoginPage
                  Navigator.pushNamed(context, LoginPage.routeName);
                }
              },
              icon: const Icon(
                Icons.person_pin,
                color: secondaryColor,
                size: 25,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.doorbell_outlined,
                color: secondaryColor,
                size: 25,
              ),
            ),
            const SizedBox(width: 5)
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              color: locationColor,
              child: InkWell(
                onTap: () async {
                  final result = await Navigator.pushNamed(context, WidgetLocation.routeName);
                  if(result != null && result is String) {
                    setState(() {
                      name = result;
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: dividerColor,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(name, style: const TextStyle(fontSize: 15)),
                        ],
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: dividerColor,
                        size: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomCarouselSlider(
              items: itemList,
              height: 135,
              subHeight: 50,
              width: 350,
              autoplay: true,
              showSubBackground: false,
              showText: false,
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildSubHeading(title: "Sedang Tayang", onTap: () => Navigator.pushNamed(context, MovieScreen.routeName)),
            ),
            StreamBuilder(
              stream: _play.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  final CarouselController carouselController = CarouselController();
                  return CarouselSlider.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    carouselController: carouselController,
                    options: CarouselOptions(
                      aspectRatio: 1.0,
                      autoPlay: true,
                      viewportFraction: 0.5,
                    ),
                    itemBuilder: (ctx, index, realIdx) {
                      final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
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
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PlayingDetailPage(playingModel: model),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Image.network(
                                  model.image,
                                  height: 300,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                model.name,
                                textAlign: TextAlign.center,
                                style: myTextTheme.titleMedium,
                              ),
                            ),
                          ],
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildSubHeading(title: "Akan Datang", onTap: () => Navigator.pushNamed(context, MovieScreen.routeName)),
            ),
            StreamBuilder(
              stream: _upcoming.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  final CarouselController carouselController = CarouselController();
                  return CarouselSlider.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    carouselController: carouselController,
                    options: CarouselOptions(
                      aspectRatio: 1.0,
                      autoPlay: true,
                      viewportFraction: 0.5,
                    ),
                    itemBuilder: (ctx, index, realIdx) {
                      final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                      final model = UpcomingModel(
                        ageRating: documentSnapshot['ageRating'],
                        director: documentSnapshot['director'],
                        duration: documentSnapshot['duration'],
                        genre: documentSnapshot['genre'],
                        image: documentSnapshot['image'],
                        name: documentSnapshot['name'],
                        synopsis: documentSnapshot['synopsis'],
                      );
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UpcomingDetailPage(upcomingModel: model),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Image.network(
                                  model.image,
                                  height: 300,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                model.name,
                                textAlign: TextAlign.center,
                                style: myTextTheme.titleMedium,
                              ),
                            ),
                          ],
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

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: myTextTheme.titleLarge,
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Text("See More"), Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ],
    );
  }
}