import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {
  final barrierWidth;
  final barrierHeight;
  final barrierX;
  final bool isThisBottomBarrier;
  const Barrier(
      {super.key,
      required this.barrierWidth,
      required this.barrierHeight,
      required this.barrierX,
      required this.isThisBottomBarrier});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * barrierX + barrierWidth) / (2 - barrierWidth),
          isThisBottomBarrier ? 1 : -1),
      child: Container(
        color: Colors.green,
        width: MediaQuery.of(context).size.width * barrierWidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * barrierHeight / 2,
      ),
    );
  }
}
