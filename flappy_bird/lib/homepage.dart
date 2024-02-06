import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'barriers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool gameHasStarted = false;
  static double barrierXOne = 2;
  double barrierXTwo = barrierXOne + 2;
  int score = 0;
  int highScore = 0;
  bool isGameOver = false;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    setState(() {
      score = 0;
      isGameOver = false;
      gameHasStarted = true;
      birdYaxis = 0;
      barrierXOne = 2;
      barrierXTwo = barrierXOne + 2;
    });

    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.035;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
      });

      setState(() {
        barrierXOne -= 0.05;
        barrierXTwo -= 0.05;
      });

      if (barrierXOne < -2) {
        barrierXOne += 4;
        score++;
      }
      if (barrierXTwo < -2) {
        barrierXTwo += 4;
        score++;
      }

      if ((birdYaxis > 1 || birdYaxis < -1.2) ||
          (birdYaxis < 1.1 &&
              birdYaxis > 0.3 &&
              (barrierXOne > -0.2 && barrierXOne < 0.2)) ||
          (birdYaxis < -0.3 &&
              birdYaxis > -1.1 &&
              (barrierXTwo > -0.2 && barrierXTwo < 0.2))) {
        timer.cancel();

        setState(() {
          isGameOver = true;
        });
        if (score > highScore) {
          highScore = score;
        }
      }
    });
  }

  void restartGame() {
    Phoenix.rebirth(context);
    birdYaxis = 0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isGameOver) {
            restartGame();
          } else if (!gameHasStarted) {
            startGame();
          } else {
            jump();
          }
        });
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  // Bird widget placeholder
                  AnimatedContainer(
                      alignment: Alignment(0, birdYaxis),
                      duration: const Duration(milliseconds: 0),
                      color: Colors.blue,
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: Image.asset('lib/images/bird.png'),
                      )),
                  Container(
                    alignment: const Alignment(0, -0.1),
                    child: gameHasStarted
                        ? const Text(" ")
                        : const Text(
                            "T A P  T O  P L A Y",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXOne, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const MyBarrier(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXOne, -1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const MyBarrier(
                      size: 220.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXTwo, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const MyBarrier(
                      size: 150.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXTwo, -1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const MyBarrier(
                      size: 270.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Center(
                  child: isGameOver
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Game Over",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                            Text(
                              "Score: $score",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                restartGame();
                              },
                              child: const Text("Restart"),
                            )
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "SCORE",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "$score",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 35),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "BEST",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "$highScore",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 35),
                                )
                              ],
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
