import 'dart:io';

import 'package:contact_diary_pr/utils/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../routes/all_routes.dart';

class HideContactScreen extends StatefulWidget {
  const HideContactScreen({super.key});

  @override
  State<HideContactScreen> createState() => _HideContactScreenState();
}

class _HideContactScreenState extends State<HideContactScreen> {
  HomeProvider read = HomeProvider();
  HomeProvider watch = HomeProvider();
  @override
  Widget build(BuildContext context) {
    read = context.read<HomeProvider>();
    watch = context.watch<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Hide Contact'),
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
                    visible: read.allContacts[index].isHidden == true,
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
