import 'package:flutter/cupertino.dart';

import '../../favorite/view/favorite_screen_ios.dart';
import '../../home/views/home_ios.dart';
import '../../recents/view/recent_screen_ios.dart';

class IosNavigateorScreen extends StatefulWidget {
  const IosNavigateorScreen({super.key});

  @override
  State<IosNavigateorScreen> createState() => _IosNavigateorScreenState();
}

class _IosNavigateorScreenState extends State<IosNavigateorScreen> {
  List<Widget> screens = [
    const HomeScreenIos(),
    const RecentScreenIos(),
    const FavoriteScreenIos(),
  ];
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.clock),
            label: 'Recent',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.star),
            label: 'Favorite',
          ),
        ]),
        tabBuilder: (context, index) => screens[index]);
  }
}
