import 'package:contact_diary_pr/utils/models/contact_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    getTheme();
  }
  List<ContactModels> allContacts = [
    ContactModels(
      name: 'John Doe',
      number: '1234567890',
      email: 'pHk6Z@example.com',
      isFavourite: false,
    ),
  ];

  List<RecentModel> recentList = [];
  bool isAndroid = true;
  int selectedIndex = 0;
  int screenIndex = 0;
  Brightness brightness = Brightness.light;
  bool isDark = false;
  void addContact(ContactModels model) {
    allContacts.add(model);
    notifyListeners();
  }

  void addRecent(RecentModel model) {
    recentList.add(model);
    notifyListeners();
  }

  void removeContact(int index) {
    allContacts.removeAt(index);
    notifyListeners();
  }

  void updateContact(ContactModels model) {
    allContacts[selectedIndex] = model;
    notifyListeners();
  }

  void favouriteContact() {
    if (allContacts[selectedIndex].isFavourite == false) {
      allContacts[selectedIndex].isFavourite = true;
    } else {
      allContacts[selectedIndex].isFavourite = false;
    }
    notifyListeners();
  }

  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void changeScreenIndex(int index) {
    screenIndex = index;
    notifyListeners();
  }

  Future<void> addProfile(
      String name, String number, String email, String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", name);
    prefs.setString("number", number);
    prefs.setString("email", email);
    prefs.setString("path", path);
    notifyListeners();
  }

  Future<String?> getProfileName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("name");
    notifyListeners();
  }

  Future<String?> getProfileNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("number");
    notifyListeners();
  }

  Future<String?> getProfileEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("email");

    notifyListeners();
  }

  Future<String?> getProfilePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("path");
    notifyListeners();
  }

  Future<void> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark = prefs.getBool("isDark") ?? false;
    isAndroid = prefs.getBool("isAndroid") ?? true;
    notifyListeners();
  }

  Future<void> changeBrightness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark = !isDark;
    prefs.setBool("isDark", isDark);
    notifyListeners();
  }

  Future<void> changePlatform() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isAndroid = !isAndroid;
    prefs.setBool("isAndroid", isAndroid);
    notifyListeners();
  }
}
