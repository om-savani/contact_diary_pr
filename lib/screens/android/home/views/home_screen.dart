import 'dart:io';

import 'package:contact_diary_pr/routes/all_routes.dart';
import 'package:contact_diary_pr/utils/models/contact_model.dart';
import 'package:contact_diary_pr/utils/my_extantions.dart';
import 'package:contact_diary_pr/utils/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name, number, email, path;
  @override
  void initState() {
    super.initState();
    getProfile();
  }

  Future<void> getProfile() async {
    name = await watch.getProfileName() as String;
    number = await watch.getProfileNumber() as String;
    email = await watch.getProfileEmail() as String;
    path = await watch.getProfilePath() as String;
  }

  HomeProvider read = HomeProvider();
  HomeProvider watch = HomeProvider();

  @override
  Widget build(BuildContext context) {
    read = context.read<HomeProvider>();
    watch = context.watch<HomeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Diary'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.addContact);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.profile);
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 50,
                      foregroundImage: path != null && path!.isNotEmpty
                          ? FileImage(File(path!))
                          : null,
                      child: path == null || path!.isEmpty
                          ? const Icon(Icons.person, size: 50)
                          : null,
                    ),
                    5.h,
                    Text(name ?? "Profile Name"),
                    5.h,
                  ],
                ),
              ),
              5.h,
              const Divider(
                thickness: 1,
              ),
              10.h,
              Switch(
                value: watch.isAndroid,
                onChanged: (value) {
                  read.changePlatform();
                },
              ),
              10.h,
              Switch(
                value: watch.isDark,
                onChanged: (value) {
                  read.changeBrightness(value);
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: read.allContacts.isEmpty
            ? const Center(
                child: Text("No Contact"),
              )
            : ListView.builder(
                itemCount: watch.allContacts.length,
                itemBuilder: (context, index) {
                  return Visibility(
                    visible: read.allContacts[index].isHidden == false,
                    child: ListTile(
                      onLongPress: () {
                        read.removeContact(index);
                      },
                      onTap: () {
                        read.changeIndex(index);
                        Navigator.pushNamed(context, AppRoutes.details,
                            arguments: read.allContacts[index]);
                      },
                      leading: CircleAvatar(
                        foregroundImage: FileImage(
                            File(watch.allContacts[index].image ?? '')),
                        child: Center(
                          child: Text(
                              " ${watch.allContacts[index].name!.substring(0, 1).toUpperCase()}"),
                        ),
                      ),
                      title: Text("${watch.allContacts[index].name}"),
                      subtitle: Text("${watch.allContacts[index].number}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.phone),
                        onPressed: () {
                          Uri(
                            scheme: 'tel',
                            path: "${watch.allContacts[index].number}",
                          );
                          RecentModel model = RecentModel(
                            name: watch.allContacts[index].name,
                            number: watch.allContacts[index].number,
                            email: watch.allContacts[index].email,
                            image: watch.allContacts[index].image,
                            date: DateTime.now(),
                          );
                          read.addRecent(model);
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

/*
* => homescreen
* => detailscreen
* => addcontact
* => hidecontact
* => insert,update,delete*/
