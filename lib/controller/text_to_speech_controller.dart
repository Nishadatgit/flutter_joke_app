import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechController extends GetxController {
  RxBool isPlaying = false.obs;
  FlutterTts flutterTts = FlutterTts();

  playAudio(String text) async {
    isPlaying.value = true;
    await flutterTts.setLanguage("en-US");

    await flutterTts.setSpeechRate(.4);

    await flutterTts.setVolume(.6);

    await flutterTts.setPitch(1.0);

    await flutterTts.speak(text);
    isPlaying.value = false;
  }
}
