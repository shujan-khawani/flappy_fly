import 'dart:async';
import 'package:flappy_fly/components/barrier.dart';
import 'package:flappy_fly/components/fly.dart';
import 'package:flappy_fly/components/my_gradient_container.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  // Check if game has started
  bool gameStarted = false;

  // Variables for Fly Equation
  static double flyY = 0;
  double initialPosition = flyY;
  double height = 0;
  double time = 0;
  double gravity = -4.5; // Gravity Strength
  double velocity = 3; // Jump Strength
  double flyWidth = 0.1;
  double flyHeight = 0.1;

  // Variables for Barriers
  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6],
  ];

  void startGame() {
    gameStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      // Quadratic equation for flying physics
      height = gravity * time * time + velocity * time;
      setState(() {
        flyY = initialPosition - height;
      });

      // Update barriers' position
      setState(() {
        for (int i = 0; i < barrierX.length; i++) {
          barrierX[i] -= 0.01; // Adjust this value to change the speed of barriers
        }
      });

      // Check if barriers are out of the screen
      if (barrierX[0] < -1.5) {
        barrierX[0] += 3;
      }
      if (barrierX[1] < -1.5) {
        barrierX[1] += 3;
      }

      // Dead Check
      if (flyIsDead() == true) {
        timer.cancel();
        _showDialog();
      }

      // Keep time going
      time += 0.01;
    });
  }

  void fly() {
    time = 0; // Reset time for the next jump
    initialPosition = flyY; // So the next jump occurs from the current location of the fly
  }

  bool flyIsDead() {
    // Check if Fly is Dead
    if (flyY < -1 || flyY > 1) {
      return true;
    }

    // Check if bird is within x and y coordinates of barriers
    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= flyWidth &&
          barrierX[i] + barrierWidth >= -flyWidth &&
          (flyY <= -1 + barrierHeight[i][0] ||
              flyY + flyHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }
    return false;
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.background,
            title: Center(
              child: Text(
                'HaHa You Died',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 20,
                ),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: Center(
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      'Play Again',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      flyY = 0;
      gameStarted = false;
      time = 0;
      initialPosition = flyY;
      barrierX = [2, 2 + 1.5]; // Reset barriers position
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameStarted ? fly : startGame,
      child: Scaffold(
        body: Column(
          children: [
            // SKY
            Expanded(
              flex: 3,
              child: MyGradientContainer(
                color1: Colors.blue.shade600,
                color2: Colors.lightBlueAccent.shade100,
                child: Stack(
                  children: [
                    Fly(
                      flyY: flyY,
                      flyHeight: flyHeight,
                      flyWidth: flyWidth,
                    ),
                    Container(
                      alignment: const Alignment(0, -0.5),
                      child: Text(
                        gameStarted ? '' : 'Tap To Fly',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Barrier(
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[0][0],
                      barrierX: barrierX[0],
                      isThisBottomBarrier: false,
                    ),
                    Barrier(
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[0][1],
                      barrierX: barrierX[0],
                      isThisBottomBarrier: true,
                    ),
                    Barrier(
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[1][0],
                      barrierX: barrierX[1],
                      isThisBottomBarrier: false,
                    ),
                    Barrier(
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[1][1],
                      barrierX: barrierX[1],
                      isThisBottomBarrier: true,
                    ),
                  ],
                ),
              ),
            ),

            // Ground
            Expanded(
              flex: 1,
              child: MyGradientContainer(
                color1: Colors.green,
                color2: Colors.brown,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
