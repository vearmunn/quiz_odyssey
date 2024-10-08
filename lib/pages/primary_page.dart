import 'package:flutter/material.dart';
import 'package:quiz_odyssey/pages/homepage.dart';
import 'package:quiz_odyssey/pages/leaderboard_page.dart';
import 'package:quiz_odyssey/pages/profile_page.dart';
import 'package:quiz_odyssey/theme/colors.dart';

class PrimaryPage extends StatefulWidget {
  const PrimaryPage({super.key});

  @override
  State<PrimaryPage> createState() => _PrimaryPageState();
}

class _PrimaryPageState extends State<PrimaryPage> {
  List<Widget> pages = [
    const Homepage(),
    const LeaderboardPage(),
    const ProfilePage(),
  ];
  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedPage],
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey.shade700,
          selectedItemColor: Colors.white,
          backgroundColor: navBarColor,
          currentIndex: selectedPage,
          onTap: (value) {
            setState(() {
              selectedPage = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.leaderboard), label: 'Leaderboard'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ]),
    );
  }
}
