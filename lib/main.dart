import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:joke_app/screens/joke_home.dart';

import 'controller/joke_by_type_controller.dart';
import 'controller/joke_controller.dart';
import 'controller/joke_type_selector_controller.dart';
import 'controller/text_to_speech_controller.dart';
import 'controller/weather_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injectDependencies();
  runApp(const MyApp());
}

Future<void> injectDependencies() async {
  Get.put(JokeTypeSelectorController());
  Get.put(JokeByTypeController());
  Get.put(WeatherController());
  Get.put(JokeController());
  Get.put(TextToSpeechController());
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
