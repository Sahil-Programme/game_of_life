import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  static const route = '/gamePage';

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool flag = false; // signifies the mediaquerry request
  final gameCol = 500; // size of game matrix
  final gameRow = 500;

  late double height; // Available screen size
  late double width;

  int xStart = 0; // offset for the canvas
  int yStart = 0;

  int canvasCol = 75; // size of the canvas
  int canvasRow = 50;

  List<List<bool>> currentStateMatrix = List.empty(); // current state
  List<List<bool>> futureStateMatrix = List.empty(); // future state

  @override
  void initState() {
    Wakelock.enable();
    randomise();
    super.initState();
  }

  void randomise() {
    currentStateMatrix = List.generate(
      gameRow,
      (index) => List.generate(
        gameCol,
        (index) => Random().nextBool(),
        growable: false,
      ),
      growable: false,
    );
    futureStateMatrix = List.generate(
      gameRow,
      (index) => List.generate(
        gameCol,
        (index) => false,
        growable: false,
      ),
      growable: false,
    );
  }

  void stateUpdate() {
    for (int r = 0; r < gameRow; r++) {
      for (int c = 0; c < gameCol; c++) {
        int liveCells = 0;
        if (r == 0 || c == 0 || r == (gameRow - 1) || c == (gameCol - 1)) {
          futureStateMatrix[r][c] = false;
          continue;
        }

        if (currentStateMatrix[r - 1][c - 1] == true) {
          liveCells++;
        }
        if (currentStateMatrix[r - 1][c] == true) {
          liveCells++;
        }
        if (currentStateMatrix[r - 1][c + 1] == true) {
          liveCells++;
        }
        if (currentStateMatrix[r][c - 1] == true) {
          liveCells++;
        }
        if (currentStateMatrix[r][c + 1] == true) {
          liveCells++;
        }
        if (currentStateMatrix[r + 1][c - 1] == true) {
          liveCells++;
        }
        if (currentStateMatrix[r + 1][c] == true) {
          liveCells++;
        }
        if (currentStateMatrix[r + 1][c + 1] == true) {
          liveCells++;
        }

        if (liveCells == 3 && currentStateMatrix[r][c] == false) {
          futureStateMatrix[r][c] = true;
        } else if (currentStateMatrix[r][c] == true &&
            (liveCells == 2 || liveCells == 3)) {
          futureStateMatrix[r][c] = true;
        } else {
          futureStateMatrix[r][c] = false;
        }
      }
    }
    for (int row = 0; row < gameRow; row++) {
      currentStateMatrix[row] = [...futureStateMatrix[row]];
    }
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    if (!flag) {
      height = MediaQuery.of(context).size.height;
      width = MediaQuery.of(context).size.width;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<List<bool>> canvasMatrix = List.generate(
      canvasRow,
      (i) => List.generate(
          canvasCol, (j) => currentStateMatrix[i + xStart][j + yStart]),
    );

    if (!flag) {
      flag = true;
      Timer.periodic(
        const Duration(milliseconds: 100),
        ((timer) {
          stateUpdate();
        }),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomPaint(
              painter: MyCanvas(
                col: canvasCol,
                row: canvasRow,
                cellMatrix: canvasMatrix,
                height: height,
                width: width,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: ElevatedButton(
                onPressed: () {
                  if (canvasCol < 100) {
                    setState(
                      () {
                        canvasCol += 10;
                        canvasRow += 10;
                      },
                    );
                  }
                },
                child: const Icon(Icons.zoom_out),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  if (canvasCol > 10) {
                    setState(
                      () {
                        canvasCol -= 10;
                        canvasRow -= 10;
                      },
                    );
                  }
                },
                child: const Icon(Icons.zoom_in),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: CustomPaint(
                      painter: MyJoystick(
                        radius: 75,
                        color: Colors.blue.withAlpha(100),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onHorizontalDragUpdate: (details) => setState(() {
                        int drag = details.delta.dx.toInt();
                        if (drag > 0 &&
                            (xStart + canvasCol + drag) < (gameCol - 1)) {
                          xStart += drag;
                        } else if (drag < 0 && (xStart + drag) > 0) {
                          xStart += drag;
                        }
                      }),
                      onVerticalDragUpdate: (details) => setState(() {
                        int drag = details.delta.dy.toInt();
                        if (drag > 0 &&
                            (yStart + canvasRow + drag) < (gameRow - 1)) {
                          yStart += drag;
                        } else if (drag < 0 && (yStart + drag) > 0) {
                          yStart += drag;
                        }
                      }),
                      child: const Icon(
                        Icons.circle,
                        size: 40,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyJoystick extends CustomPainter {
  final double radius;
  final Color color;

  MyJoystick({required this.radius, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final myPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, myPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyCanvas extends CustomPainter {
  final int col;
  final int row;

  final double height;
  final double width;

  final List<List<bool>> cellMatrix;

  MyCanvas({
    required this.col,
    required this.row,
    required this.height,
    required this.width,
    required this.cellMatrix,
  });
  @override
  void paint(Canvas canvas, Size size) {
    double stroke = 1;
    final myPaint = Paint()..strokeWidth = stroke;

    for (int r = 0; r < row; r++) {
      for (int c = 0; c < col; c++) {
        cellMatrix[r][c]
            ? {
                myPaint.style = PaintingStyle.fill,
                myPaint.color = Colors.black,
              }
            : {
                myPaint.style = PaintingStyle.fill,
                myPaint.color = Colors.white
              };
        canvas.drawRect(
          Rect.fromPoints(
            Offset(r * width / row, c * height / col),
            Offset((r + 1) * width / row, (c + 1) * height / col),
          ),
          myPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
