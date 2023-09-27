import 'package:flutter/material.dart';
import 'package:vaganza_movie/model/upcoming_model.dart';
import 'package:vaganza_movie/ui/upcoming_detail_page.dart';

class UpcomingListPage extends StatelessWidget {
  const UpcomingListPage({Key? key}) : super(key: key);

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
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.1),
              ),
              itemCount: upcomingModel.length,
              itemBuilder: (context, index) {
                UpcomingModel place = upcomingModel[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpcomingDetailPage(place: place),
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
