import 'package:flutter/material.dart';
import 'package:joke_app/api/service.dart';

import 'package:joke_app/screens/category_jokes.dart';

import 'package:joke_app/screens/random_jokes.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final List<Widget> _screens = [
    HomeScreen(),
    CategoryJokes(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            actions: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      DioService().getWeather('malappuram');
                    },
                    child: const Text(
                      '27°C',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
            ],
            elevation: 0,
            toolbarHeight: 60,
            backgroundColor: const Color.fromARGB(255, 6, 53, 91),
            title: const Text('Get A Joke'),
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
}
