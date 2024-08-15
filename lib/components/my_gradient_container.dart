import 'package:flutter/material.dart';

class MyGradientContainer extends StatelessWidget {
  final Color color1;
  final Color color2;
  final Widget child;
  const MyGradientContainer(
      {super.key,
      required this.color1,
      required this.color2,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color1,
            color2,
          ],
        ),
      ),
      child: child,
    );
  }
}
