import 'dart:io';

import 'package:contact_diary_pr/utils/models/contact_model.dart';
import 'package:contact_diary_pr/utils/my_extantions.dart';
import 'package:contact_diary_pr/utils/provider/home_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreenIos extends StatefulWidget {
  const DetailScreenIos({super.key});

  @override
  State<DetailScreenIos> createState() => _DetailScreenIosState();
}

class _DetailScreenIosState extends State<DetailScreenIos> {
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

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: const Icon(CupertinoIcons.back),
        ),
        middle: const Text('Contact Detail'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                buildShowDialog(context, model);
              },
              child: const Icon(CupertinoIcons.pencil),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                read.favouriteContact();
                Navigator.pop(context);
              },
              child: const Icon(CupertinoIcons.star),
            ),
          ],
        ),
      ),
      child: Padding(
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
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Name: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(model.name!),
                ],
              ),
              10.h,
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Email: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(model.email!),
                ],
              ),
              10.h,
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Number: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(model.number!),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildShowDialog(BuildContext context, ContactModels model) {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Edit Contact"),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(children: [
              const Text("Name"),
              10.w,
              CupertinoTextField(
                controller: nameController,
                placeholder: "Name",
              ),
            ]),
            5.h,
            CupertinoListTile(
              title: const Text("Email"),
              subtitle: CupertinoTextField(
                controller: emailController,
                placeholder: "Email",
              ),
            ),
            5.h,
            CupertinoListTile(
              title: const Text("Number"),
              subtitle: CupertinoTextField(
                controller: numberController,
                placeholder: "Number",
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              ContactModels Model = ContactModels(
                name: nameController.text,
                number: numberController.text,
                email: emailController.text,
                image: model.image,
                isFavourite: model.isFavourite,
              );
              context.read<HomeProvider>().updateContact(Model);
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
          CupertinoDialogAction(
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
