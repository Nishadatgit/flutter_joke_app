import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class CategoryJokes extends StatelessWidget {
  CategoryJokes({super.key});
  static String val = '';

  final List<String> _jokes = ['programming', 'pun', "Dark"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(),
      )),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color.fromARGB(255, 6, 53, 91),
          onPressed: () {
            _showTypes(context);
          },
          label: const Text('Select Type')),
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
                items: _jokes.map((e) => MultiSelectItem(e, e)).toList(),
                listType: MultiSelectListType.CHIP,
                onConfirm: (values) {
                  val = values.map((e) => e).join(',');

                  log(val);
                },
              ),
            ],
          );
        });
  }
}
