import 'package:calculator/controller.dart';
import 'package:calculator/sqlite.dart';
import 'package:calculator/widgets.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

class Calc extends GetView<Controller> {
  const Calc({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());
    List<Map<String, dynamic>> journals = [];
    final inputController = TextEditingController().obs;
    final outputController = TextEditingController().obs;

    void refreshJournals() async {
      final data = await SQLite.getItems();

      journals = data;
    }

    Future<void> addItem() async {
      await SQLite.createItem(controller.input.value, controller.answer.value);
      refreshJournals();
    }

    void deleteItem(String que) {
      SQLite.deleteItem(que);
      refreshJournals();
    }

    refreshJournals();
    final color = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.secondaryContainer,
        title: Text(
          'CALCULATOR',
          style: TextStyle(color: color.primary, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.bottomSheet(
                  backgroundColor: color.onSecondary,
                  ListView.builder(
                      itemCount: journals.length,
                      itemBuilder: (context, idx) {
                        int revIdx = journals.length - 1 - idx;
                        return ListTile(
                            onTap: () {
                              controller.input.value = journals[revIdx]['que'];
                              inputController.value.text = controller.input.value;
                              controller.answer.value = journals[revIdx]['ans'];
                              outputController.value.text = controller.answer.value;

                              Get.back();
                              Get.snackbar('Copied', 'History Item', duration: const Duration(seconds: 1));
                            },
                            leading: CircleAvatar(child: Text('${revIdx + 1}')),
                            title: Text(
                              '${journals[revIdx]['que']}',
                            ),
                            subtitle: Text(
                              '${journals[revIdx]['ans']}',
                            ),
                            trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  deleteItem(journals[revIdx]['que']);
                                  Get.back();
                                  Get.snackbar('Deleted', 'History Item', duration: const Duration(seconds: 1));
                                }));
                      }),
                );
              },
              icon: const Icon(Icons.history))
        ],
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: TextField(
            style: TextStyle(fontSize: size.height / 18),
            minLines: 2,
            maxLines: 2,
            controller: outputController.value,
            readOnly: true,
            decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: TextField(
            style: TextStyle(fontSize: size.height / 30),
            minLines: 1,
            maxLines: 2,
            controller: inputController.value,
            autofocus: true,
            readOnly: true,
            //showCursor: true,
            decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
          ),
        ),
        Container(
          color: color.secondaryContainer,
          height: size.height / 2.1,
          child: Column(
            children: [
              FlipCard(
                direction: FlipDirection.VERTICAL,
                front: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconBtn(iconLabel: '(', inp: inputController.value),
                    IconBtn(iconLabel: ')', inp: inputController.value),
                    IconBtn(iconLabel: '^', inp: inputController.value),
                    IconBtn(iconLabel: '!', inp: inputController.value),
                    IconBtn(iconLabel: '√', inp: inputController.value),
                    IconButton(
                        onPressed: (null),
                        icon: Text(
                          '⋮',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color.primary),
                        )),
                  ],
                ),
                back: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconBtn(iconLabel: 'log', inp: inputController.value),
                    IconBtn(iconLabel: 'cos', inp: inputController.value),
                    IconBtn(iconLabel: 'sin', inp: inputController.value),
                    IconBtn(iconLabel: 'tan', inp: inputController.value),
                    IconButton(
                        onPressed: () {
                          controller.input.value += 'nrt';
                          inputController.value.text = controller.input.value;
                        },
                        icon: const Text(
                          'n√',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        )),
                    IconButton(
                        onPressed: (null),
                        icon: Text(
                          '⋮',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color.primary),
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleBtn(
                          iconLabel: '7',
                          color: color.onSecondary,
                          inp: inputController.value,
                        ),
                        CircleBtn(
                          iconLabel: '8',
                          color: color.onSecondary,
                          inp: inputController.value,
                        ),
                        CircleBtn(
                          iconLabel: '9',
                          color: color.onSecondary,
                          inp: inputController.value,
                        ),
                        CircleBtn(
                          iconLabel: '/',
                          color: color.inversePrimary,
                          inp: inputController.value,
                        ),
                        CircleAvatar(
                          backgroundColor: color.error,
                          radius: size.shortestSide / 11,
                          child: SizedBox(
                            height: size.longestSide,
                            width: size.longestSide,
                            child: IconButton(
                              onPressed: () {
                                if (controller.input.value == '') {
                                  controller.input.value = '';
                                } else {
                                  controller.input.value = controller.input.value.substring(0, inputController.value.text.length - 1);
                                  inputController.value.text = controller.input.value;
                                }
                              },
                              icon: const Icon(Icons.backspace),
                              color: color.onError,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleBtn(
                          iconLabel: '4',
                          color: color.onSecondary,
                          inp: inputController.value,
                        ),
                        CircleBtn(
                          iconLabel: '5',
                          color: color.onSecondary,
                          inp: inputController.value,
                        ),
                        CircleBtn(
                          iconLabel: '6',
                          color: color.onSecondary,
                          inp: inputController.value,
                        ),
                        CircleBtn(
                          iconLabel: 'x',
                          color: color.inversePrimary,
                          inp: inputController.value,
                        ),
                        CircleAvatar(
                          backgroundColor: color.error,
                          radius: size.shortestSide / 11,
                          child: SizedBox(
                              height: size.longestSide,
                              width: size.longestSide,
                              child: IconButton(
                                onPressed: () {
                                  controller.input.value = '';
                                  inputController.value.text = controller.input.value;
                                  controller.answer.value = '';
                                  outputController.value.text = controller.input.value;
                                },
                                icon: Icon(Icons.delete, color: color.onError),
                              )),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleBtn(
                          iconLabel: '1',
                          color: color.onSecondary,
                          inp: inputController.value,
                        ),
                        CircleBtn(
                          iconLabel: '2',
                          color: color.onSecondary,
                          inp: inputController.value,
                        ),
                        CircleBtn(
                          iconLabel: '3',
                          color: color.onSecondary,
                          inp: inputController.value,
                        ),
                        CircleBtn(
                          iconLabel: '-',
                          color: color.inversePrimary,
                          inp: inputController.value,
                        ),
                        CircleAvatar(
                          backgroundColor: color.inversePrimary,
                          radius: size.shortestSide / 11,
                          child: SizedBox(
                              height: size.longestSide,
                              width: size.longestSide,
                              child: IconButton(
                                  onPressed: () {
                                    controller.input.value += '/100';
                                    inputController.value.text = controller.input.value;
                                  },
                                  icon: const Icon(Icons.percent))),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleBtn(
                          iconLabel: '00',
                          color: color.onSecondary,
                          inp: inputController.value,
                        ),
                        CircleBtn(
                          iconLabel: '0',
                          color: color.onSecondary,
                          inp: inputController.value,
                        ),
                        CircleBtn(
                          iconLabel: '.',
                          color: color.onSecondary,
                          inp: inputController.value,
                        ),
                        CircleBtn(
                          iconLabel: '+',
                          color: color.inversePrimary,
                          inp: inputController.value,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: size.shortestSide / 11,
                          child: SizedBox(
                              height: size.longestSide,
                              width: size.longestSide,
                              child: IconButton(
                                  onPressed: () {
                                    if (controller.input.value.isNotEmpty) {
                                      String finalUserInp = controller.input.value;
                                      finalUserInp = controller.input.value.replaceAll('x', '*');
                                      String finalUserInput = finalUserInp.replaceAll('√', 'sqrt');
                                      Expression exp = Parser().parse(finalUserInput);
                                      double eval = exp.evaluate(EvaluationType.REAL, ContextModel());
                                      controller.answer.value = eval.toString();
                                      if (controller.answer.endsWith('.0')) {
                                        controller.answer.value = controller.answer.substring(0, controller.answer.value.length - 2);
                                      }
                                      outputController.value.text = controller.answer.value;
                                      controller.input.value = '(${controller.input.value})';
                                      inputController.value.text = controller.input.value;
                                      addItem();
                                    }
                                  },
                                  icon: const Text(
                                    '=',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                                  ))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
