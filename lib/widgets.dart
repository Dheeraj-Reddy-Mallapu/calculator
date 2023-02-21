import 'package:flutter/material.dart';

class CircleBtn extends StatelessWidget {
  final Function circleBtnState;
  final String iconLabel;
  final Color color;
  const CircleBtn({super.key, required this.circleBtnState, required this.iconLabel, required this.color});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CircleAvatar(
      backgroundColor: color,
      radius: size.shortestSide / 11,
      child: SizedBox(
          height: size.longestSide,
          width: size.longestSide,
          child: IconButton(
            onPressed: () => circleBtnState(iconLabel),
            icon: Text(
              iconLabel,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          )),
    );
  }
}

class IconBtn extends StatelessWidget {
  final Function iconBtnState;
  final String iconLabel;
  const IconBtn({super.key, required this.iconBtnState, required this.iconLabel});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => iconBtnState(iconLabel),
      icon: Text(
        iconLabel,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
