import 'package:flutter/cupertino.dart';

class Fly extends StatelessWidget {
  final double flyY;
  final double flyHeight;
  final double flyWidth;
  const Fly(
      {super.key,
      required this.flyY,
      required this.flyHeight,
      required this.flyWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, flyY),
      child: Image.asset(
        'images/Flappy Fly.png',
        height: MediaQuery.of(context).size.height * 3 / 4 * flyHeight / 2,
        width: MediaQuery.of(context).size.height * flyWidth / 2,
        fit: BoxFit.fill,
      ),
    );
  }
}
