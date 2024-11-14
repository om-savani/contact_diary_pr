import 'dart:io';

import 'package:contact_diary_pr/utils/my_extantions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../utils/models/contact_model.dart';
import '../../../../utils/provider/home_provider.dart';

class ProfileScreenIos extends StatefulWidget {
  const ProfileScreenIos({super.key});

  @override
  State<ProfileScreenIos> createState() => _ProfileScreenIosState();
}

class _ProfileScreenIosState extends State<ProfileScreenIos> {
  HomeProvider read = HomeProvider();
  HomeProvider watch = HomeProvider();
  int stepIndex = 0;
  String? path;
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    read = context.read<HomeProvider>();
    watch = context.watch<HomeProvider>();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: const Icon(CupertinoIcons.back),
        ),
        middle: const Text('Add Contact'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                if (stepIndex == 0)
                  Column(
                    children: [
                      path == null
                          ? const CircleAvatar(
                              radius: 60,
                              child: Icon(CupertinoIcons.person),
                            )
                          : CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(File(path!)),
                            ),
                      10.h,
                      CupertinoButton.filled(
                        onPressed: () async {
                          ImagePicker imagePicker = ImagePicker();
                          XFile? image = await imagePicker.pickImage(
                              source: ImageSource.gallery);
                          setState(
                            () {
                              path = image?.path;
                            },
                          );
                        },
                        child: const Text('Add Photo'),
                      ),
                    ],
                  ),
                if (stepIndex == 1)
                  CupertinoTextField(
                    controller: nameController,
                    placeholder: 'Name',
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                  ),
                if (stepIndex == 2)
                  CupertinoTextField(
                    controller: numberController,
                    placeholder: 'Number',
                    keyboardType: TextInputType.number,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    maxLength: 10,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                if (stepIndex == 3)
                  CupertinoTextField(
                    controller: emailController,
                    placeholder: 'Email',
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                  ),
                if (stepIndex == 4)
                  CupertinoButton.filled(
                    onPressed: () {
                      bool isValid = formKey.currentState?.validate() ?? false;
                      if (isValid) {
                        String name = nameController.text;
                        String number = numberController.text;
                        String email = emailController.text;
                        read.addProfile(name, number, email, path ?? '');
                        Navigator.pop(context);
                      } else {
                        showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoAlertDialog(
                            title: const Text('Error'),
                            content: const Text('Please Fill All Fields'),
                            actions: [
                              CupertinoDialogAction(
                                isDefaultAction: true,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: const Text('Save Contact'),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (stepIndex > 0)
                      CupertinoButton(
                        onPressed: () {
                          setState(() {
                            stepIndex--;
                          });
                        },
                        child: const Text('Previous'),
                      ),
                    if (stepIndex < 4)
                      CupertinoButton(
                        onPressed: () {
                          setState(() {
                            stepIndex++;
                          });
                        },
                        child: const Text('Next'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
