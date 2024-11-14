import 'dart:io';

import 'package:contact_diary_pr/routes/all_ios_routes.dart';
import 'package:contact_diary_pr/utils/my_extantions.dart';
import 'package:contact_diary_pr/utils/provider/home_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/models/contact_model.dart';

class HomeScreenIos extends StatefulWidget {
  const HomeScreenIos({super.key});

  @override
  State<HomeScreenIos> createState() => _HomeScreenIosState();
}

class _HomeScreenIosState extends State<HomeScreenIos> {
  HomeProvider read = HomeProvider();
  HomeProvider watch = HomeProvider();
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

  @override
  Widget build(BuildContext context) {
    read = context.read<HomeProvider>();
    watch = context.watch<HomeProvider>();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Contact Diary'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.add),
              onPressed: () {
                Navigator.pushNamed(context, IosRoutes.addContact);
              },
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.ellipsis_vertical),
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) => CupertinoActionSheet(
                    title: const Text('Options'),
                    actions: [
                      CupertinoActionSheetAction(
                        onPressed: () {
                          showCupertinoDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
                                  title: const Text("Profile"),
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 50,
                                        foregroundImage:
                                            path != null && path!.isNotEmpty
                                                ? FileImage(File(path!))
                                                : null,
                                        child: path == null || path!.isEmpty
                                            ? const Icon(Icons.person, size: 50)
                                            : null,
                                      ),
                                      5.h,
                                      Text("Name: ${name ?? "Not Found"}"),
                                      5.h,
                                      Text("Number: ${number ?? "Not Found"}"),
                                      5.h,
                                      Text("Email: ${email ?? "Not Found"}"),
                                    ],
                                  ),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: const Text("Close"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: const Text("Edit"),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, IosRoutes.profile);
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        child: const Text("Profile Setting"),
                      ),
                      CupertinoActionSheetAction(
                        onPressed: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: const Text("Settings"),
                                content: Column(
                                  children: [
                                    5.h,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text("Dark Mode"),
                                        CupertinoSwitch(
                                          value: watch.isDark ?? false,
                                          onChanged: (value) {
                                            read.changeBrightness();
                                          },
                                        ),
                                      ],
                                    ),
                                    5.h,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text("Theme"),
                                        CupertinoSwitch(
                                          value: watch.isAndroid ?? true,
                                          onChanged: (value) {
                                            read.changePlatform();
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                actions: [
                                  CupertinoDialogAction(
                                    child: const Text("Close"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text("Setting"),
                      ),
                    ],
                    cancelButton: CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: read.allContacts.isEmpty
                  ? const Center(child: Text("No Contact"))
                  : ListView.builder(
                      itemCount: watch.allContacts.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            read.changeIndex(index);
                            Navigator.pushNamed(context, IosRoutes.details,
                                arguments: read.allContacts[index]);
                          },
                          child: CupertinoListTile(
                            title: Text("${watch.allContacts[index].name}"),
                            subtitle:
                                Text("${watch.allContacts[index].number}"),
                            leading: CircleAvatar(
                              foregroundImage: FileImage(
                                  File(watch.allContacts[index].image ?? '')),
                              child: Center(
                                child: Text(watch.allContacts[index].name!
                                    .substring(0, 1)
                                    .toUpperCase()),
                              ),
                            ),
                            trailing: CupertinoButton(
                              child: const Icon(CupertinoIcons.phone),
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
          ),
        ],
      ),
    );
  }
}
