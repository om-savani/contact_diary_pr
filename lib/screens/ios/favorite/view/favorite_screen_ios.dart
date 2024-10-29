import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../routes/all_ios_routes.dart';
import '../../../../routes/all_routes.dart';
import '../../../../utils/provider/home_provider.dart';

class FavoriteScreenIos extends StatefulWidget {
  const FavoriteScreenIos({super.key});

  @override
  State<FavoriteScreenIos> createState() => _FavoriteScreenIosState();
}

class _FavoriteScreenIosState extends State<FavoriteScreenIos> {
  HomeProvider read = HomeProvider();
  HomeProvider watch = HomeProvider();

  @override
  Widget build(BuildContext context) {
    read = context.read<HomeProvider>();
    watch = context.watch<HomeProvider>();

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Favorites'),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: read.allContacts.isEmpty
            ? const Center(
                child: Text("No Contact"),
              )
            : ListView.builder(
                itemCount: watch.allContacts.length,
                itemBuilder: (context, index) {
                  return Visibility(
                    visible: read.allContacts[index].isFavourite == true,
                    child: GestureDetector(
                      onTap: () {
                        read.changeIndex(index);
                        Navigator.pushNamed(
                          context,
                          IosRoutes.details,
                          arguments: read.allContacts[index],
                        );
                      },
                      child: CupertinoListTile(
                        leading: CircleAvatar(
                          foregroundImage: FileImage(
                              File(watch.allContacts[index].image ?? '')),
                          child: Center(
                            child: Text(
                              " ${watch.allContacts[index].name!.substring(0, 1).toUpperCase()}",
                            ),
                          ),
                        ),
                        title: Text("${watch.allContacts[index].name}"),
                        subtitle: Text("${watch.allContacts[index].number}"),
                        trailing: CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: const Icon(CupertinoIcons.phone),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
