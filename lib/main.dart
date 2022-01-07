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
      body: LayoutBuilder(builder: (ctx, constraint) {
        late final List<Widget> list = [];
        late final List<Widget> col = [];
        for (double i = 0;
            i < constraint.maxWidth - constraint.maxWidth / 30;
            i = i + constraint.maxWidth / 30) {
          list.add(
            Cell(
                width: constraint.maxWidth / 30,
                height: constraint.maxWidth / 30),
          );
        }
        for (double i = 0;
            i < constraint.maxHeight - constraint.maxHeight / 30;
            i = i + constraint.maxWidth / 30) {
          col.add(Row(
            children: list,
          ));
        }
        return Center(
          child: Column(
            children: col,
          ),
        );
      }),
    );
  }
}

class Cell extends StatefulWidget {
  const Cell({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);
  final double width;
  final double height;

  @override
  State<Cell> createState() => _CellState();
}

class _CellState extends State<Cell> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isPressed = isPressed ? false : true;
        });
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            color: isPressed ? Colors.red : Colors.white,
            border: Border.all(width: 0.25, color: Colors.black)),
      ),
    );
  }
}
