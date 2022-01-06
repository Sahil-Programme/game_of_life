import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Game Of Life',
      home: MyHomePage(title: 'Game Of Life'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (ctx, constraint) {
          late List<Container> list = [];
          for (double x = 0;
              x < constraint.maxWidth;
              x = x + constraint.maxWidth / 50) {
            list.add(
              Container(
                width: constraint.maxWidth / 50,
                height: constraint.maxHeight,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                ),
              ),
            );
          }
          return Row(
            children: list,
          );
        },
      ),
    );
  }
}
