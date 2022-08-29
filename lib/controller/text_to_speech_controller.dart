import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechController extends GetxController {
  FlutterTts flutterTts = FlutterTts();
  RxBool isPlaying = false.obs;

  playAudio(String text) async {
    isPlaying.value = true;
    await flutterTts.setLanguage("en-GB");

    await flutterTts.setSpeechRate(.4);

    await flutterTts.setVolume(.6);

    await flutterTts.setPitch(1.0);
    flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(text);
    isPlaying.value = false;
  }
}
