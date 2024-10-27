import 'package:contact_diary_pr/utils/models/contact_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  List<ContactModels> allContacts = [
    ContactModels(
      name: 'John Doe',
      number: '1234567890',
      email: 'pHk6Z@example.com',
      isHidden: false,
      isFavourite: false,
    ),
  ];

  int selectedIndex = 0;
  void addContact(ContactModels model) {
    allContacts.add(model);
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

  void hideContact() {
    if (allContacts[selectedIndex].isHidden == false) {
      allContacts[selectedIndex].isHidden = true;
    } else {
      allContacts[selectedIndex].isHidden = false;
    }
    notifyListeners();
  }

  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  // void incrementStepIndex() {
  //   if (stepIndex < 4) {
  //     stepIndex++;
  //   }
  //   notifyListeners();
  // }

  // void decrementStepIndex() {
  //   if (stepIndex > 0) {
  //     stepIndex--;
  //   }
  //   notifyListeners();
  // }
}
