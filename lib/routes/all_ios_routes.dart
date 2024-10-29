import 'package:contact_diary_pr/screens/ios/addcontact/view/add_contact_ios.dart';
import 'package:contact_diary_pr/screens/ios/home/views/home_ios.dart';
import 'package:flutter/cupertino.dart';

class IosRoutes {
  static String home = "/";
  static String addContact = "addContactIos";
  // static String details = "detailScreen";
  // static String hidecontact = "hidecontact";
  // static String favourite = "favourite";
  // static String recent = "recent";
  // static String profile = "profile";

  static Map<String, WidgetBuilder> allRoutes = {
    "/": (context) => const HomeScreenIos(),
    "addContactIos": (context) => const AddContactIos(),
    // "detailScreen": (context) => const DetailScreen(),
    // "hidecontact": (context) => const HideContactScreen(),
    // "favourite": (context) => const FavoriteScreen(),
    // "recent": (context) => const RecentScreen(),
    // "profile": (context) => const ProfileScreen(),
  };
}
