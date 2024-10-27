import 'dart:io';

import 'package:contact_diary_pr/routes/all_routes.dart';
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
                    CircleAvatar(
                      radius: 50,
                      // foregroundImage: FileImage(),
                    ),
                    5.h,
                    Text("Profile Name"),
                    5.h,
                  ],
                ),
              ),
              10.h,
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.hidecontact);
                  },
                  child: const Text("Hide Contact")),
              10.h,
              ElevatedButton(
                  onPressed: () {}, child: const Text("Profile Setting")),
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
                        onPressed: () {},
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
