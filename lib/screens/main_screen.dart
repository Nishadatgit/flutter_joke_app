import 'package:flutter/material.dart';

import 'package:joke_app/screens/home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  final   List<Widget> _screens = [
    HomeScreen(),
   const Scaffold(),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 6, 53, 91),
          title: const Text('Get A Joke'),
          centerTitle: true,
          bottom: TabBar(
            indicatorWeight: 3,
            tabs: const [
              Tab(
                icon: Icon(Icons.shuffle),
              ),
              Tab(
                icon: Icon(Icons.category),
              )
            ],
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ),
        body: _screens[selectedIndex],
      ),
    );
  }
}
