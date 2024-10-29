import 'package:contact_diary_pr/routes/all_ios_routes.dart';
import 'package:contact_diary_pr/routes/all_routes.dart';
import 'package:contact_diary_pr/utils/provider/home_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: HomeProvider()),
      ],
      child: Consumer<HomeProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return value.isAndroid
              ? MaterialApp(
                  theme: ThemeData(brightness: value.brightness),
                  debugShowCheckedModeBanner: false,
                  routes: AppRoutes.allRoutes,
                )
              : CupertinoApp(
                  debugShowCheckedModeBanner: false,
                  routes: IosRoutes.allRoutes,
                  theme: CupertinoThemeData(brightness: value.brightness),
                );
        },
      ),
    );
  }
}
