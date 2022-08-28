import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:joke_app/controller/joke_by_type_controller.dart';
import 'package:joke_app/controller/joke_type_selector_controller.dart';
import 'package:joke_app/model/joke_type_model.dart';
import 'package:joke_app/screens/shimmer/random_jokes_shimmer.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class CategoryJokes extends StatelessWidget {
  CategoryJokes({super.key});
  final JokeTypeSelectorController jokeTypeSelectorController =
      Get.put(JokeTypeSelectorController());
  final JokeByTypeController jokeByTypeController =
      Get.put(JokeByTypeController());

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
              if (jokeTypeSelectorController.val.value != '') {
                jokeByTypeController
                    .refreshGetJokeByType(jokeTypeSelectorController.val.value);
              } else {
                Get.snackbar('Cannot reload', 'Please select a type',
                    colorText: Colors.white, backgroundColor: Colors.red);
              }
            },
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: const Color.fromARGB(255, 6, 53, 91)
                            .withOpacity(0.1),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          _showTypes(context);
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Obx(
                                () => Text(
                                  jokeTypeSelectorController.val.value != ''
                                      ? jokeTypeSelectorController.val.value
                                          .replaceAll(',', '-')
                                      : 'Please Select A Joke Type',
                                  style: TextStyle(
                                      color: jokeTypeSelectorController
                                                  .val.value !=
                                              ''
                                          ? Colors.black
                                          : Colors.grey,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                _buildBody(context)
              ],
            ),
          ),
        ),
        floatingActionButton: _buildFloatingActionButton());
  }

  Obx _buildFloatingActionButton() {
    return Obx(
      () => jokeTypeSelectorController.val.value != ''
          ? jokeByTypeController.isLoading.value
              ? SizedBox(
                  height: 50,
                  width: 50,
                  child: LoadingAnimationWidget.inkDrop(
                      color: Colors.yellow, size: 40),
                )
              : SizedBox(
                  height: 50,
                  width: 50,
                  child: FloatingActionButton(
                    backgroundColor: Colors.yellow,
                    onPressed: () {
                      jokeByTypeController
                          .getJokeByType(jokeTypeSelectorController.val.value);
                    },
                    child: const Icon(
                      FontAwesomeIcons.arrowsRotate,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                )
          : const SizedBox.shrink(),
    );
  }

  Obx _buildBody(BuildContext context) {
    return Obx(
      () => jokeByTypeController.isInitState.value
          ? const SizedBox.shrink()
          : jokeByTypeController.isLoading.value
              ? const RandomJokesShimmer(
                  isCategory: true,
                )
              : Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
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
                                () => jokeByTypeController
                                            .jokeByType.value.joke !=
                                        null
                                    ? Text(
                                        jokeByTypeController
                                                .jokeByType.value.joke ??
                                            '',
                                        style: const TextStyle(
                                            fontSize: 25,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        jokeByTypeController
                                                .jokeByType.value.setup ??
                                            '',
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ),
                              const SizedBox(height: 10),
                              Obx(
                                () => Text(
                                  jokeByTypeController
                                          .jokeByType.value.delivery ??
                                      '',
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
                                            backgroundColor:
                                                jokeByTypeController
                                                        .jokeByType.value.safe!
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
                                      jokeByTypeController
                                          .jokeByType.value.category!,
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
    );
  }

  void _showTypes(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return SimpleDialog(
            backgroundColor: Colors.grey[100],
            contentPadding: const EdgeInsets.all(20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: const Text('Selected Items appear here'),
            children: [
              MultiSelectDialogField(
                selectedColor: const Color.fromARGB(255, 6, 53, 91),
                selectedItemsTextStyle: const TextStyle(color: Colors.white),
                backgroundColor: Colors.grey[100],
                searchIcon: const Icon(Icons.search),
                searchable: true,
                unselectedColor: Colors.grey[300],
                searchHint: 'Serach Joke types',
                title: const Text('Select Joke Types'),
                items: jokeTypes
                    .map((e) => MultiSelectItem(e.value, e.name))
                    .toList(),
                listType: MultiSelectListType.CHIP,
                onConfirm: (values) {
                  jokeTypeSelectorController.val.value =
                      values.map((e) => e).join(',');
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton.icon(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        jokeTypeSelectorController.val.value = '';
                        Get.back();
                        Get.snackbar('Note', 'Selection cleared',
                            duration: const Duration(seconds: 2),
                            colorText: Colors.white,
                            backgroundColor:
                                Colors.transparent.withOpacity(0.5));
                      },
                      icon: const Icon(
                        FontAwesomeIcons.broom,
                        size: 20,
                      ),
                      label: const Text('Clear')),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 6, 53, 91)),
                      onPressed: () {
                        if (jokeTypeSelectorController.val.value != '') {
                          jokeByTypeController.getJokeByType(
                              jokeTypeSelectorController.val.value);
                          Get.back();
                        } else {
                          Get.snackbar('Warning', 'Please select a type',
                              backgroundColor: Colors.orange,
                              colorText: Colors.white);
                        }
                      },
                      icon: const Icon(FontAwesomeIcons.solidFloppyDisk),
                      label: const Text('Save'))
                ],
              )
            ],
          );
        });
  }
}
