import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joke_app/controller/joke_controller.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen extends GetView<JokeController> {
  HomeScreen({super.key});

  final JokeController jokeController = Get.put(JokeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LiquidPullToRefresh(
          animSpeedFactor: 2,
          height: 100,
          backgroundColor: Colors.black,
          springAnimationDurationInMilliseconds: 800,
          color: Colors.yellow,
          onRefresh: () async {
            jokeController.isLoading.value = true;
            jokeController.refreshItems();
          },
          child: ListView(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text('Category: ',
                                  style: TextStyle(color: Colors.grey)),
                              Obx(
                                () => Text(
                                  jokeController.joke.value.category!,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
      floatingActionButton: Obx(() => !jokeController.isLoading.value
          ? AnimatedContainer(
              height: 50,
              width: 50,
              duration: const Duration(milliseconds: 400),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.yellow,
              ),
              child: IconButton(
                  onPressed: () {
                    jokeController.refreshItems();
                  },
                  icon: !jokeController.isLoading.value
                      ? const Icon(
                          Icons.shuffle,
                          color: Colors.black,
                          size: 25,
                        )
                      : const SizedBox.shrink()),
            )
          : SizedBox(
              height: 50,
              width: 50,
              child: LoadingAnimationWidget.inkDrop(
                  color: Colors.yellow, size: 40))),
    );
  }
}
