
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test/app/views/bottombar/main_page.dart';
import 'package:machine_test/utils/colors.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      home: const MainPage(),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colours.kDarkBackgroundColor,
        
        
      ),
    );
  }
}
