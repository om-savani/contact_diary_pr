import 'package:contact_diary_pr/screens/android/favorite/views/favorite_screen.dart';
import 'package:contact_diary_pr/screens/android/home/views/home_screen.dart';
import 'package:contact_diary_pr/utils/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../recent/view/recent_screen.dart';

class NavigatScreen extends StatefulWidget {
  const NavigatScreen({super.key});

  @override
  State<NavigatScreen> createState() => _NavigatScreenState();
}

class _NavigatScreenState extends State<NavigatScreen> {
  HomeProvider read = HomeProvider();
  HomeProvider write = HomeProvider();
  List<Widget> screens = [
    const HomeScreen(),
    const RecentScreen(),
    const FavoriteScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    read = context.read<HomeProvider>();
    write = context.watch<HomeProvider>();
    return Scaffold(
      body: screens[read.screenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: read.screenIndex,
        onTap: (index) {
          read.changeScreenIndex(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Contact'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Recent'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorite'),
        ],
      ),
    );
  }
}
