import 'package:contact_diary_pr/screens/android/detail/views/detail_screen.dart';
import 'package:contact_diary_pr/screens/android/home/views/home_screen.dart';
import 'package:contact_diary_pr/screens/android/navigator/view/navigat_screen.dart';
import 'package:flutter/cupertino.dart';
import '../screens/android/addcontact/views/add_contact.dart';
import '../screens/android/favorite/views/favorite_screen.dart';
import '../screens/android/profile/view/profile_screen.dart';
import '../screens/android/recent/view/recent_screen.dart';

class AppRoutes {
  static String navigator = "/";

  static String home = "home";
  static String addContact = "addContactPage";
  static String details = "detailScreen";
  static String favourite = "favourite";
  static String recent = "recent";
  static String profile = "profile";

  static Map<String, WidgetBuilder> allRoutes = {
    "/": (context) => const NavigatScreen(),
    'home': (context) => const HomeScreen(),
    "addContactPage": (context) => const AddContact(),
    "detailScreen": (context) => const DetailScreen(),
    "favourite": (context) => const FavoriteScreen(),
    "recent": (context) => const RecentScreen(),
    "profile": (context) => const ProfileScreen(),
  };
}
