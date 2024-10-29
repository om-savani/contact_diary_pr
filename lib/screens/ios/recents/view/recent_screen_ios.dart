import 'dart:io';

import 'package:contact_diary_pr/utils/provider/home_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../routes/all_routes.dart';
import '../../../../utils/models/contact_model.dart';

class RecentScreenIos extends StatefulWidget {
  const RecentScreenIos({super.key});

  @override
  State<RecentScreenIos> createState() => _RecentScreenIosState();
}

class _RecentScreenIosState extends State<RecentScreenIos> {
  HomeProvider read = HomeProvider();
  HomeProvider watch = HomeProvider();

  @override
  Widget build(BuildContext context) {
    read = context.read<HomeProvider>();
    watch = context.watch<HomeProvider>();

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Recent'),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: read.recentList.isEmpty
            ? const Center(
                child: Text("No Recent"),
              )
            : ListView.builder(
                itemCount: watch.recentList.length,
                itemBuilder: (context, index) {
                  return CupertinoListTile(
                    leading: CircleAvatar(
                      foregroundImage:
                          FileImage(File(watch.recentList[index].image ?? '')),
                      child: Center(
                        child: Text(
                          " ${watch.recentList[index].name!.substring(0, 1).toUpperCase()}",
                        ),
                      ),
                    ),
                    title: Text("${watch.recentList[index].name}"),
                    subtitle: Text("${watch.recentList[index].number}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: const Icon(CupertinoIcons.phone),
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
                          "${watch.recentList[index].date?.hour}:${watch.recentList[index].date?.minute}",
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
