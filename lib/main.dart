import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:joke_app/screens/joke_home.dart';
import 'package:joke_app/screens/shimmer/random_jokes_shimmer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: JokeHome(),
    );
  }
}
