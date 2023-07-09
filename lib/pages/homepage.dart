import 'package:flutter/material.dart';
import 'package:game_of_life/pages/game_page.dart';

import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const route = '/homepage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _heading = "GAME OF LIFE";

  final _subHeading = "John Conways";

  final _debugDecoration =
      BoxDecoration(border: Border.all(width: 1, color: Colors.transparent));

  bool pressed = false;

  final textStyle = const TextStyle(
    shadows: [
      Shadow(
        color: Colors.black,
        blurRadius: 0,
        offset: Offset(5, 5),
      )
    ],
    color: Colors.white,
    fontSize: 50,
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() {
    pressed = false;
    super.initState();
  }

  void startGame(BuildContext context) {
    Navigator.pushNamed(context, GamePage.route);
  }

  Widget startButton(BuildContext ctx) {
    return GestureDetector(
      onTap: () {
        setState(() {
          pressed = true;
        });

        startGame(ctx);
      },
      child: Container(
        decoration: BoxDecoration(
          color: pressed ? Colors.black : Colors.white,
          boxShadow: [
            BoxShadow(
              color: pressed ? Colors.black : Colors.white,
              offset: const Offset(7, 7),
            ),
            BoxShadow(
              color: !pressed ? Colors.black : Colors.white,
              offset: const Offset(5, 5),
            ),
          ],
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: !pressed ? Colors.black : Colors.white,
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(20),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Start',
              style: GoogleFonts.kanit(
                textStyle: TextStyle(
                  color: !pressed ? Colors.black : Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: Colors.white,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: startButton(context),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: _debugDecoration,
                    child: Text(
                      _subHeading,
                      style: GoogleFonts.kanit(
                          textStyle: const TextStyle(fontSize: 25)),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    decoration: _debugDecoration,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          _heading,
                          style: GoogleFonts.kanit(
                            textStyle: textStyle.copyWith(
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..color = Colors.black
                                ..strokeWidth = 2,
                              color: null,
                            ),
                          ),
                        ),
                        Text(
                          _heading,
                          style: GoogleFonts.kanit(
                            textStyle: textStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
