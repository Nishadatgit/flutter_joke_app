import 'package:flutter/material.dart';

class CategoryJokes extends StatelessWidget {
  CategoryJokes({super.key});
  List tags = [];
  List<String> options = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [],
      )),
    );
  }
}

/*
List<String> tags = [];


@override
Widget build(BuildContext context) {
  return ChipsChoice<String>.multiple(
    value: tags,
    onChanged: (val) => setState(() => tags = val),
    choiceItems: C2Choice.listFrom<String, String>(
      source: options,
      value: (i, v) => v,
      label: (i, v) => v,
    ),
  );
}




*/
