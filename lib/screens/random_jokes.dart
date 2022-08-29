import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:joke_app/controller/joke_controller.dart';
import 'package:joke_app/controller/text_to_speech_controller.dart';
import 'package:joke_app/widgets/shimmer/random_jokes_shimmer.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen extends GetView<JokeController> {
  HomeScreen({super.key});

  final JokeController jokeController = Get.find<JokeController>();
  final TextToSpeechController textToSpeechController =
      Get.find<TextToSpeechController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
          child: LiquidPullToRefresh(
        animSpeedFactor: 2,
        height: 50,
        showChildOpacityTransition: false,
        backgroundColor: Colors.white,
        springAnimationDurationInMilliseconds: 1000,
        color: const Color.fromARGB(255, 6, 53, 91),
        onRefresh: () async {
          textToSpeechController.flutterTts.stop();
          textToSpeechController.isPlaying.value = false;
          jokeController.refreshItems();
        },
        child: ListView(
          children: [
            Obx(() => jokeController.isLoading.value
                ? const RandomJokesShimmer()
                : Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(20),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => jokeController.joke.value.joke != null
                                      ? Text(
                                          jokeController.joke.value.joke ?? '',
                                          style: const TextStyle(
                                              fontSize: 25,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          jokeController.joke.value.setup ?? '',
                                          style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ),
                                const SizedBox(height: 10),
                                Obx(
                                  () => Text(
                                    jokeController.joke.value.delivery ?? '',
                                    style: const TextStyle(
                                        fontSize: 25,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const Text(
                                            'Safe:  ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          ),
                                          Obx(
                                            () => CircleAvatar(
                                              radius: 10,
                                              backgroundColor: jokeController
                                                      .joke.value.safe!
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Obx(
                                            () => AvatarGlow(
                                              endRadius: 30,
                                              animate: textToSpeechController
                                                  .isPlaying.value,
                                              repeat: true,
                                              duration: const Duration(
                                                  milliseconds: 2000),
                                              repeatPauseDuration:
                                                  const Duration(
                                                      milliseconds: 100),
                                              glowColor: Colors.black,
                                              child: InkWell(
                                                onTap: () {
                                                  if (textToSpeechController
                                                          .isPlaying.value ==
                                                      true) {
                                                    textToSpeechController
                                                        .flutterTts
                                                        .stop();
                                                    textToSpeechController
                                                        .isPlaying
                                                        .value = false;
                                                  } else {
                                                    playJoke();
                                                  }
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color:
                                                              Color.fromARGB(
                                                                  255,
                                                                  6,
                                                                  53,
                                                                  91),
                                                          shape:
                                                              BoxShape.circle),
                                                  child: textToSpeechController
                                                          .isPlaying.value
                                                      ? const Icon(
                                                          Icons.mic_off,
                                                          size: 16,
                                                          color: Colors.white)
                                                      : const Icon(Icons.mic,
                                                          size: 16,
                                                          color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Text('Category: ',
                                        style: TextStyle(color: Colors.grey)),
                                    Obx(
                                      () => Text(
                                        jokeController.joke.value.category!,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
          ],
        ),
      )),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Obx _buildFloatingActionButton() {
    return Obx(() => !jokeController.isLoading.value
        ? Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.yellow,
            ),
            child: IconButton(
                onPressed: () {
                  jokeController.refreshItems();
                  textToSpeechController.flutterTts.stop();
                  textToSpeechController.isPlaying.value = false;
                },
                icon: const Icon(
                  Icons.shuffle,
                  color: Colors.black,
                  size: 25,
                )),
          )
        : SizedBox(
            height: 50,
            width: 50,
            child: LoadingAnimationWidget.inkDrop(
                color: Colors.yellow, size: 40)));
  }

  void playJoke() async {
    if (jokeController.joke.value.joke == null) {
      final setup = jokeController.joke.value.setup!;

      final delivery = jokeController.joke.value.delivery!;
      await textToSpeechController.playAudio('$setup .. $delivery');
    } else {
      final text = jokeController.joke.value.joke;
      textToSpeechController.playAudio(text!);
    }
  }
}
