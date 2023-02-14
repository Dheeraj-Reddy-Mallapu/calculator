import 'package:flutter/material.dart';

class CircleBtn extends StatelessWidget {
  const CircleBtn({super.key, required this.iconButton});
  final IconButton iconButton;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme;
    return CircleAvatar(
      backgroundColor: color.onSecondary,
      radius: size.shortestSide / 11,
      child: SizedBox(
          height: size.longestSide, width: size.longestSide, child: iconButton),
    );
  }
}

class MyIcon extends StatelessWidget {
  const MyIcon({super.key, required this.iconLabel});
  final String iconLabel;

  @override
  Widget build(BuildContext context) {
    return Text(
      iconLabel,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
    );
  }
}
