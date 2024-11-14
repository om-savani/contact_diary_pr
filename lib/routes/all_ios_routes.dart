import 'package:contact_diary_pr/screens/ios/addcontact/view/add_contact_ios.dart';
import 'package:contact_diary_pr/screens/ios/detail/view/detail_screen_ios.dart';
import 'package:contact_diary_pr/screens/ios/favorite/view/favorite_screen_ios.dart';
import 'package:contact_diary_pr/screens/ios/home/views/home_ios.dart';
import 'package:contact_diary_pr/screens/ios/navigator/views/ios_navigateor_screen.dart';
import 'package:contact_diary_pr/screens/ios/profile/view/profile_screen_ios.dart';
import 'package:contact_diary_pr/screens/ios/recents/view/recent_screen_ios.dart';
import 'package:flutter/cupertino.dart';

class IosRoutes {
  static String navigator = "/";
  static String home = "home";
  static String addContact = "addContactIos";
  static String details = "detailScreen";
  static String favourite = "favourite";
  static String recent = "recent";
  static String profile = "profile";

  static Map<String, WidgetBuilder> allRoutes = {
    "/": (context) => const IosNavigateorScreen(),
    "home": (context) => const HomeScreenIos(),
    "addContactIos": (context) => const AddContactIos(),
    "detailScreen": (context) => const DetailScreenIos(),
    "favourite": (context) => const FavoriteScreenIos(),
    "recent": (context) => const RecentScreenIos(),
    "profile": (context) => const ProfileScreenIos(),
  };
}
