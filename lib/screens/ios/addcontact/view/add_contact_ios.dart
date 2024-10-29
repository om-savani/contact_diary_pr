import 'dart:io';

import 'package:contact_diary_pr/utils/my_extantions.dart';
import 'package:contact_diary_pr/utils/provider/home_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../utils/models/contact_model.dart';

class AddContactIos extends StatefulWidget {
  const AddContactIos({super.key});

  @override
  State<AddContactIos> createState() => _AddContactIosState();
}

class _AddContactIosState extends State<AddContactIos> {
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
                  CupertinoTextFormFieldRow(
                    controller: nameController,
                    placeholder: 'Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                  ),
                if (stepIndex == 2)
                  CupertinoTextFormFieldRow(
                    controller: numberController,
                    placeholder: 'Number',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Number';
                      } else if (value.length < 10) {
                        return 'Number Must Be 10 Digit';
                      }
                      return null;
                    },
                    maxLength: 10,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                // Step 4: Email
                if (stepIndex == 3)
                  CupertinoTextFormFieldRow(
                    controller: emailController,
                    placeholder: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Email';
                      }
                      return null;
                    },
                  ),
                // Step 5: Save Button
                if (stepIndex == 4)
                  CupertinoButton.filled(
                    onPressed: () {
                      bool isValid = formKey.currentState?.validate() ?? false;
                      if (isValid) {
                        String name = nameController.text;
                        String number = numberController.text;
                        String email = emailController.text;

                        ContactModels details = ContactModels(
                          name: name,
                          number: number,
                          email: email,
                          image: path,
                          isFavourite: false,
                        );
                        read.addContact(details);
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
