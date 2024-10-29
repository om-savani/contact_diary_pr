import 'dart:io';

import 'package:contact_diary_pr/utils/models/contact_model.dart';
import 'package:contact_diary_pr/utils/my_extantions.dart';
import 'package:contact_diary_pr/utils/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  HomeProvider read = HomeProvider();
  HomeProvider watch = HomeProvider();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    read = context.read<HomeProvider>();
    watch = context.watch<HomeProvider>();
    ContactModels model =
        ModalRoute.of(context)!.settings.arguments as ContactModels;
    nameController.text = model.name!;
    numberController.text = model.number!;
    emailController.text = model.email!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Contact Detail'),
        actions: [
          IconButton(
            onPressed: () {
              buildShowDialog(context, model);
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              read.favouriteContact();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.star_border),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                foregroundImage: FileImage(
                  File(model.image ?? ''),
                ),
                child: Center(
                  child: Text(
                    model.name!.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              50.h,
              ListTile(
                leading: const Text(
                  "Name: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                title: Text(model.name!),
              ),
              10.h,
              ListTile(
                leading: const Text(
                  "Email: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                title: Text(model.email!),
              ),
              10.h,
              ListTile(
                leading: const Text(
                  "Number: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                title: Text(model.number!),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildShowDialog(BuildContext context, ContactModels model) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Contact"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
              ),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),
            TextField(
              controller: numberController,
              decoration: const InputDecoration(labelText: "Number"),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              ContactModels cmodel = ContactModels(
                name: nameController.text,
                number: numberController.text,
                email: emailController.text,
                image: model.image,
                isFavourite: model.isFavourite,
              );
              context.read<HomeProvider>().updateContact(cmodel);
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
