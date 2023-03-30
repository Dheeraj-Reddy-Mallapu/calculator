import 'package:calculator/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircleBtn extends GetView<Controller> {
  const CircleBtn({
    super.key,
    required this.iconLabel,
    required this.color,
    required this.inp,
  });
  final String iconLabel;
  final Color color;
  final TextEditingController inp;

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
            onPressed: () {
              controller.input.value += iconLabel;
              inp.text = controller.input.value;
            },
            icon: Text(
              iconLabel,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.height / 22),
            ),
          )),
    );
  }
}

class IconBtn extends GetView<Controller> {
  const IconBtn({super.key, required this.iconLabel, required this.inp});
  final String iconLabel;
  final TextEditingController inp;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        controller.input.value += iconLabel;
        inp.text = controller.input.value;
      },
      icon: Text(
        iconLabel,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
