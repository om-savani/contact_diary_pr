import 'dart:io';

import 'package:contact_diary_pr/utils/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../routes/all_routes.dart';
import '../../../../utils/models/contact_model.dart';

class RecentScreen extends StatefulWidget {
  const RecentScreen({super.key});

  @override
  State<RecentScreen> createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen> {
  HomeProvider read = HomeProvider();
  HomeProvider watch = HomeProvider();
  @override
  Widget build(BuildContext context) {
    read = context.read<HomeProvider>();
    watch = context.watch<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: read.recentList.isEmpty
            ? const Center(
                child: Text("No Contact"),
              )
            : ListView.builder(
                itemCount: watch.recentList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onLongPress: () {
                      read.removeContact(index);
                    },
                    // onTap: () {
                    //   read.changeIndex(index);
                    //   Navigator.pushNamed(context, AppRoutes.details,
                    //       arguments: read.allContacts[index]);
                    // },
                    leading: CircleAvatar(
                      foregroundImage:
                          FileImage(File(watch.recentList[index].image ?? '')),
                      child: Center(
                        child: Text(
                            " ${watch.recentList[index].name!.substring(0, 1).toUpperCase()}"),
                      ),
                    ),
                    title: Text("${watch.recentList[index].name}"),
                    subtitle: Text("${watch.recentList[index].number}"),
                    trailing: Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.phone),
                            onPressed: () {
                              Uri(
                                scheme: 'tel',
                                path: "${watch.recentList[index].number}",
                              );
                              RecentModel model = RecentModel(
                                name: watch.recentList[index].name,
                                number: watch.recentList[index].number,
                                email: watch.recentList[index].email,
                                image: watch.recentList[index].image,
                                date: DateTime.now(),
                              );
                              read.addRecent(model);
                            },
                          ),
                          Text(
                              "${watch.recentList[index].date?.hour}:${watch.recentList[index].date?.minute}"),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
