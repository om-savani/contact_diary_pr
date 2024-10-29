import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../routes/all_routes.dart';
import '../../../../utils/provider/home_provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  HomeProvider read = HomeProvider();
  HomeProvider watch = HomeProvider();
  @override
  Widget build(BuildContext context) {
    read = context.read<HomeProvider>();
    watch = context.watch<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
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
                    visible: read.allContacts[index].isFavourite == true,
                    child: ListTile(
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
