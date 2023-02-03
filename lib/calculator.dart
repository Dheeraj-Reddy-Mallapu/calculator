import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String input = '';
  String answer = '';

  @override
  Widget build(BuildContext context) {
    //var inpCalc = input.text.trim();
    final TextEditingController inp = TextEditingController(text: input);
    String finalUserInput = input;
    finalUserInput = input.replaceAll('x', '*');

    final TextEditingController out = TextEditingController(text: answer);
    return Scaffold(
      appBar: AppBar(
        title: const Text('CALCULATOR'),
        centerTitle: true,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    style: const TextStyle(fontSize: 38),
                    minLines: 2,
                    maxLines: 2,
                    controller: out,
                    readOnly: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    style: const TextStyle(fontSize: 28),
                    minLines: 1,
                    maxLines: 2,
                    controller: inp,
                    readOnly: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.orangeAccent,
                      radius: MediaQuery.of(context).size.shortestSide / 12,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.longestSide,
                        width: MediaQuery.of(context).size.longestSide,
                        child: IconButton(
                            onPressed: () => setState(() {
                                  input += '(';
                                }),
                            icon: const Text(
                              '(',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            )),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.orangeAccent,
                      radius: MediaQuery.of(context).size.shortestSide / 12,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.longestSide,
                        width: MediaQuery.of(context).size.longestSide,
                        child: IconButton(
                            onPressed: () => setState(() {
                                  input += ')';
                                }),
                            icon: const Text(
                              ')',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            )),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: MediaQuery.of(context).size.shortestSide / 12,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.longestSide,
                        width: MediaQuery.of(context).size.longestSide,
                        child: IconButton(
                            onPressed: () => setState(() {
                                  input += '^';
                                }),
                            icon: const Text(
                              '^',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            )),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: MediaQuery.of(context).size.shortestSide / 12,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.longestSide,
                        width: MediaQuery.of(context).size.longestSide,
                        child: IconButton(
                            onPressed: () => setState(() {
                                  input += 'sqrt';
                                }),
                            icon: const Text(
                              '√',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            )),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.orangeAccent,
                      radius: MediaQuery.of(context).size.shortestSide / 12,
                      child: SizedBox(
                          height: MediaQuery.of(context).size.longestSide,
                          width: MediaQuery.of(context).size.longestSide,
                          child: IconButton(
                              onPressed: () => setState(() {
                                    if (input == '') {
                                      input = '';
                                    } else {
                                      input = input.substring(
                                          0, input.toString().length - 1);
                                    }
                                  }),
                              icon: const Icon(Icons.backspace))),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.shortestSide / 12,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.longestSide,
                        width: MediaQuery.of(context).size.longestSide,
                        child: IconButton(
                            onPressed: () => setState(() {
                                  input += '7';
                                }),
                            icon: const Text(
                              '7',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            )),
                      ),
                    ),
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.shortestSide / 12,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.longestSide,
                        width: MediaQuery.of(context).size.longestSide,
                        child: IconButton(
                            onPressed: () => setState(() {
                                  input += '8';
                                }),
                            icon: const Text(
                              '8',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            )),
                      ),
                    ),
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.shortestSide / 12,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.longestSide,
                        width: MediaQuery.of(context).size.longestSide,
                        child: IconButton(
                            onPressed: () => setState(() {
                                  input += '9';
                                }),
                            icon: const Text(
                              '9',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            )),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: MediaQuery.of(context).size.shortestSide / 12,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.longestSide,
                        width: MediaQuery.of(context).size.longestSide,
                        child: IconButton(
                            onPressed: () => setState(() {
                                  input += '/';
                                }),
                            icon: const Text(
                              '/',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            )),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.orangeAccent,
                      radius: MediaQuery.of(context).size.shortestSide / 12,
                      child: SizedBox(
                          height: MediaQuery.of(context).size.longestSide,
                          width: MediaQuery.of(context).size.longestSide,
                          child: IconButton(
                              onPressed: () => setState(() {
                                    input = '';
                                    answer = '';
                                  }),
                              icon: const Icon(Icons.delete))),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.shortestSide / 12,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.longestSide,
                        width: MediaQuery.of(context).size.longestSide,
                        child: IconButton(
                            onPressed: () => setState(() {
                                  input += '4';
                                }),
                            icon: const Text(
                              '4',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            )),
                      ),
                    ),
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.shortestSide / 12,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.longestSide,
                        width: MediaQuery.of(context).size.longestSide,
                        child: IconButton(
                            onPressed: () => setState(() {
                                  input += '5';
                                }),
                            icon: const Text(
                              '5',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            )),
                      ),
                    ),
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.shortestSide / 12,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.longestSide,
                        width: MediaQuery.of(context).size.longestSide,
                        child: IconButton(
                            onPressed: () => setState(() {
                                  input += '6';
                                }),
                            icon: const Text(
                              '6',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            )),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: MediaQuery.of(context).size.shortestSide / 12,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.longestSide,
                        width: MediaQuery.of(context).size.longestSide,
                        child: IconButton(
                            onPressed: () => setState(() {
                                  input += 'x';
                                }),
                            icon: const Text(
                              'X',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            )),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: MediaQuery.of(context).size.shortestSide / 12,
                      child: SizedBox(
                          height: MediaQuery.of(context).size.longestSide,
                          width: MediaQuery.of(context).size.longestSide,
                          child: IconButton(
                              onPressed: () => setState(() {
                                    input += '!';
                                  }),
                              icon: const Text(
                                '!',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ))),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.shortestSide / 12,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.longestSide,
                        width: MediaQuery.of(context).size.longestSide,
                        child: IconButton(
                            onPressed: () => setState(() {
                                  input += '1';
                                }),
                            icon: const Text(
                              '1',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            )),
                      ),
                    ),
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.shortestSide / 12,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.longestSide,
                        width: MediaQuery.of(context).size.longestSide,
                        child: IconButton(
                            onPressed: () => setState(() {
                                  input += '2';
                                }),
                            icon: const Text(
                              '2',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            )),
                      ),
                    ),
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.shortestSide / 12,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.longestSide,
                        width: MediaQuery.of(context).size.longestSide,
                        child: IconButton(
                            onPressed: () => setState(() {
                                  input += '3';
                                }),
                            icon: const Text(
                              '3',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            )),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: MediaQuery.of(context).size.shortestSide / 12,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.longestSide,
                        width: MediaQuery.of(context).size.longestSide,
                        child: IconButton(
                            onPressed: () => setState(() {
                                  input += '-';
                                }),
                            icon: const Text(
                              '-',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            )),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: MediaQuery.of(context).size.shortestSide / 12,
                      child: SizedBox(
                          height: MediaQuery.of(context).size.longestSide,
                          width: MediaQuery.of(context).size.longestSide,
                          child: IconButton(
                              onPressed: () => setState(() {
                                    input += '/100';
                                  }),
                              icon: const Icon(Icons.percent))),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.shortestSide / 12,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.longestSide,
                        width: MediaQuery.of(context).size.longestSide,
                        child: IconButton(
                            onPressed: () => setState(() {
                                  input += '00';
                                }),
                            icon: const Text(
                              '00',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            )),
                      ),
                    ),
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.shortestSide / 12,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.longestSide,
                        width: MediaQuery.of(context).size.longestSide,
                        child: IconButton(
                            onPressed: () => setState(() {
                                  input += '0';
                                }),
                            icon: const Text(
                              '0',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            )),
                      ),
                    ),
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.shortestSide / 12,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.longestSide,
                        width: MediaQuery.of(context).size.longestSide,
                        child: IconButton(
                            onPressed: () => setState(() {
                                  input += '.';
                                }),
                            icon: const Text(
                              '.',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            )),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: MediaQuery.of(context).size.shortestSide / 12,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.longestSide,
                        width: MediaQuery.of(context).size.longestSide,
                        child: IconButton(
                            onPressed: () => setState(() {
                                  input += '+';
                                }),
                            icon: const Text(
                              '+',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            )),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.lightGreen,
                      radius: MediaQuery.of(context).size.shortestSide / 12,
                      child: SizedBox(
                          height: MediaQuery.of(context).size.longestSide,
                          width: MediaQuery.of(context).size.longestSide,
                          child: IconButton(
                              onPressed: () {
                                if (input.isNotEmpty) {
                                  setState(() {
                                    Expression exp =
                                        Parser().parse(finalUserInput);
                                    double eval = exp.evaluate(
                                        EvaluationType.REAL, ContextModel());
                                    answer = eval.toString();
                                  });
                                }
                              },
                              icon: const Text(
                                '=',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ))),
                    ),
                  ],
                ),
              ],
            )
          ]),
    );
  }
}
