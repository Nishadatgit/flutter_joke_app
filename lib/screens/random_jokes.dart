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
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: jokeController.isLoading.value
              ? Center(
                  child: LoadingAnimationWidget.twoRotatingArc(
                      color: const Color.fromARGB(255, 6, 53, 91), size: 100))
              : LiquidPullToRefresh(
                  animSpeedFactor: 1,
                  height: 50,
                  backgroundColor: Colors.white,
                  springAnimationDurationInMilliseconds: 1500,
                  color: const Color.fromARGB(255, 6, 53, 91),
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
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 1),
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
                                          )
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
                  ),
                ),
        ),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  Obx _buildFloatingActionButton() {
    return Obx(() => !jokeController.isLoading.value
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
                color: Colors.yellow, size: 40)));
  }
}
