import 'package:contact_diary_pr/screens/android/detail/views/detail_screen.dart';
import 'package:contact_diary_pr/screens/android/home/views/home_screen.dart';
import 'package:flutter/cupertino.dart';
import '../screens/android/addcontact/views/add_contact.dart';
import '../screens/android/hidecontact/views/hide_contact.dart';

class AppRoutes {
  static String addContact = "addContactPage";
  static String details = "detailScreen";
  static String hidecontact = "hidecontact";

  static Map<String, WidgetBuilder> allRoutes = {
    '/': (context) => const HomeScreen(),
    "addContactPage": (context) => const AddContact(),
    "detailScreen": (context) => const DetailScreen(),
    "hidecontact": (context) => const HideContactScreen(),
  };
}
