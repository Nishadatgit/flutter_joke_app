import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joke_app/controller/weather_controller.dart';
import 'package:joke_app/model/weather_model/weather_model.dart';
import 'package:joke_app/screens/category_jokes.dart';

import 'package:joke_app/screens/random_jokes.dart';
import 'package:shimmer/shimmer.dart';

class JokeHome extends StatelessWidget {
  JokeHome({super.key});
  final List<Widget> _screens = [
    HomeScreen(),
    CategoryJokes(),
  ];
  final WeatherController weatherController = Get.put(WeatherController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back_ios),
              iconSize: 20,
            ),
            leadingWidth: 20,
            actions: [
              Obx(
                () => weatherController.isUpdated.value
                    ? Row(
                        children: [
                          InkWell(
                            onTap: () {
                              weatherController.getWeather(
                                  weatherController.currentCity.value);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${weatherController.currentWeather.value.feelsLike}°',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      'C',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      getWeatherEmoji(weatherController),
                                      style: const TextStyle(fontSize: 20),
                                    )
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    //
                                    //show  weather popup
                                    showWeatherPopup(
                                        weatherController.currentWeather.value,
                                        context);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'Malappuram',
                                        style: TextStyle(
                                            color: Colors.grey[300],
                                            letterSpacing: 0,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.grey[400],
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10)
                        ],
                      )
                    : Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 5),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[400]!,
                                highlightColor: Colors.grey[200]!,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(5)),
                                  width: 100,
                                  height: 20,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey[400]!,
                                    highlightColor: Colors.grey[200]!,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      width: 80,
                                      height: 15,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey[400]!,
                                    highlightColor: Colors.grey[200]!,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      width: 15,
                                      height: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
              )
            ],
            elevation: 0,
            toolbarHeight: 60,
            backgroundColor: const Color.fromARGB(255, 6, 53, 91),
            title: const Text('Jokes'),
            bottom: TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              labelStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              unselectedLabelColor: Colors.grey,
              indicatorWeight: 3,
              tabs: const [
                Tab(
                  text: 'Random',
                ),
                Tab(
                  text: 'Category',
                )
              ],
              onTap: (index) {},
            ),
          ),
          body: TabBarView(children: _screens)),
    );
  }

  String getWeatherEmoji(WeatherController controller) {
    if (controller.currentWeather.value.feelsLike! > 26 &&
        controller.currentWeather.value.feelsLike! < 35) {
      return '☀';
    } else if (controller.currentWeather.value.feelsLike! <= 26) {
      return '🌥';
    } else if (controller.currentWeather.value.feelsLike! > 20 &&
        controller.currentWeather.value.feelsLike! < 23) {
      return '🌨';
    } else {
      return '❄';
    }
  }

  //
  //
  void showWeatherPopup(WeatherModel model, BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return SimpleDialog(
            backgroundColor: Colors.transparent,
            contentPadding: const EdgeInsets.all(20),
            title: Text(
              'Weather ${getWeatherEmoji(weatherController)} ',
              style: TextStyle(color: Colors.grey[400]!),
            ),
            children: [
              Text(
                "Temperature :${model.feelsLike.toString()}",
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                "Humidity :${model.humidity.toString()}",
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )
            ],
          );
        });
  }
}
