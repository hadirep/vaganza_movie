import 'package:flutter/material.dart';
import 'package:vaganza_movie/ui/my_account_page.dart';
import 'package:vaganza_movie/ui/playing_list_page.dart';
import 'package:vaganza_movie/ui/upcoming_list_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'vaganza_home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MainMenu();
}

class _MainMenu extends State<HomePage> {
  int selectedPage = 0;

  final _page = [const PlayingListPage(), const UpcomingListPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow_outlined),
            label: 'Playing',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upcoming_outlined),
            label: 'Upcoming',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        currentIndex: selectedPage,
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
    );
  }
}
