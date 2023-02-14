import 'package:calculator/widgets.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';
import 'sqlite.dart';
import 'package:flip_card/flip_card.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String input = '';
  String answer = '';

  List<Map<String, dynamic>> _journals = [];

  void _refreshJournals() async {
    final data = await SQLite.getItems();
    setState(() {
      _journals = data;
    });
  }

  @override
  initState() {
    super.initState();
    _refreshJournals();
  }

  Future<void> _addItem() async {
    await SQLite.createItem(input, answer);
    _refreshJournals();
  }

  void _deleteItem(String que) {
    SQLite.deleteItem(que);
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme;

    final TextEditingController inp = TextEditingController(text: input);
    String finalUserInp = input;
    finalUserInp = input.replaceAll('x', '*');
    String finalUserInput = finalUserInp.replaceAll('√', 'sqrt');

    final TextEditingController out = TextEditingController(text: answer);
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
              onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: ((context) => ListView.builder(
                      itemCount: _journals.length,
                      itemBuilder: (context, idx) {
                        int revIdx = _journals.length - 1 - idx;
                        return ListTile(
                            onTap: () {
                              setState(() {
                                input = _journals[revIdx]['que'];
                                answer = _journals[revIdx]['ans'];
                              });
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Pasted')));
                            },
                            leading: CircleAvatar(child: Text('${revIdx + 1}')),
                            title: Text('${_journals[revIdx]['que']}'),
                            subtitle: Text('${_journals[revIdx]['ans']}'),
                            trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _deleteItem(_journals[revIdx]['que']);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Deleted')));
                                }));
                      }))),
              icon: const Icon(Icons.history))
        ],
      ),
      body: Column(children: <Widget>[
        const SizedBox(height: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              autofocus: true,
              style: const TextStyle(fontSize: 40),
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
              style: const TextStyle(fontSize: 30),
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
        const SizedBox(height: 10),
        Expanded(
          child: Container(
            color: color.secondaryContainer,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlipCard(
                  direction: FlipDirection.VERTICAL,
                  front: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                          label: const Text(''),
                          onPressed: () => setState(() {
                                input += '(';
                              }),
                          icon: const Text(
                            '  (',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          )),
                      ElevatedButton.icon(
                          label: const Text(''),
                          onPressed: () => setState(() {
                                input += ')';
                              }),
                          icon: const Text(
                            '    )',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          )),
                      ElevatedButton.icon(
                          label: const Text(''),
                          onPressed: () => setState(() {
                                input += '^';
                              }),
                          icon: const Text(
                            '   ^',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          )),
                      ElevatedButton.icon(
                          label: const Text(''),
                          onPressed: () => setState(() {
                                input += '!';
                              }),
                          icon: const Text(
                            '   !',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          )),
                      ElevatedButton.icon(
                          label: const Text(''),
                          onPressed: () => setState(() {
                                input += '√';
                              }),
                          icon: const Text(
                            '   √',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          )),
                      const IconButton(
                          onPressed: (null),
                          icon: Text(
                            '⋮',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          )),
                    ],
                  ),
                  back: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                          label: const Text(''),
                          onPressed: () => setState(() {
                                input += 'log';
                              }),
                          icon: const Text(
                            'log',
                            style: TextStyle(fontSize: 18),
                          )),
                      ElevatedButton.icon(
                          label: const Text(''),
                          onPressed: () => setState(() {
                                input += 'cos';
                              }),
                          icon: const Text(
                            'cos',
                            style: TextStyle(fontSize: 18),
                          )),
                      ElevatedButton.icon(
                          label: const Text(''),
                          onPressed: () => setState(() {
                                input += 'sin';
                              }),
                          icon: const Text(
                            'sin',
                            style: TextStyle(fontSize: 18),
                          )),
                      ElevatedButton.icon(
                          label: const Text(''),
                          onPressed: () => setState(() {
                                input += 'tan';
                              }),
                          icon: const Text(
                            'tan',
                            style: TextStyle(fontSize: 18),
                          )),
                      ElevatedButton.icon(
                          label: const Text(''),
                          onPressed: () => setState(() {
                                input += 'nrt';
                              }),
                          icon: const Text(
                            'n√',
                            style: TextStyle(fontSize: 18),
                          )),
                      const IconButton(
                          onPressed: (null),
                          icon: Text(
                            '⋮',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          )),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleBtn(
                      iconButton: IconButton(
                          onPressed: () => setState(() {
                                input += '7';
                              }),
                          icon: const MyIcon(iconLabel: '7')),
                    ),
                    CircleBtn(
                        iconButton: IconButton(
                            onPressed: () => setState(() {
                                  input += '8';
                                }),
                            icon: const MyIcon(iconLabel: '8'))),
                    CircleBtn(
                        iconButton: IconButton(
                            onPressed: () => setState(() {
                                  input += '9';
                                }),
                            icon: const MyIcon(iconLabel: '9'))),
                    CircleAvatar(
                      backgroundColor: color.inversePrimary,
                      radius: size.shortestSide / 11,
                      child: SizedBox(
                        height: size.longestSide,
                        width: size.longestSide,
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
                      backgroundColor: color.error,
                      radius: size.shortestSide / 11,
                      child: SizedBox(
                        height: size.longestSide,
                        width: size.longestSide,
                        child: IconButton(
                          onPressed: () => setState(() {
                            if (input == '') {
                              input = '';
                            } else {
                              input = input.substring(
                                  0, input.toString().length - 1);
                            }
                          }),
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
                        iconButton: IconButton(
                            onPressed: () => setState(() {
                                  input += '4';
                                }),
                            icon: const MyIcon(iconLabel: '4'))),
                    CircleBtn(
                        iconButton: IconButton(
                            onPressed: () => setState(() {
                                  input += '5';
                                }),
                            icon: const MyIcon(iconLabel: '5'))),
                    CircleBtn(
                        iconButton: IconButton(
                            onPressed: () => setState(() {
                                  input += '6';
                                }),
                            icon: const MyIcon(iconLabel: '6'))),
                    CircleAvatar(
                      backgroundColor: color.inversePrimary,
                      radius: size.shortestSide / 11,
                      child: SizedBox(
                        height: size.longestSide,
                        width: size.longestSide,
                        child: IconButton(
                            onPressed: () => setState(() {
                                  input += 'x';
                                }),
                            icon: const Text(
                              'x',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            )),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: color.error,
                      radius: size.shortestSide / 11,
                      child: SizedBox(
                          height: size.longestSide,
                          width: size.longestSide,
                          child: IconButton(
                            onPressed: () => setState(() {
                              input = '';
                              answer = '';
                            }),
                            icon: Icon(Icons.delete, color: color.onError),
                          )),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleBtn(
                        iconButton: IconButton(
                            onPressed: () => setState(() {
                                  input += '1';
                                }),
                            icon: const MyIcon(iconLabel: '1'))),
                    CircleBtn(
                        iconButton: IconButton(
                            onPressed: () => setState(() {
                                  input += '2';
                                }),
                            icon: const MyIcon(iconLabel: '2'))),
                    CircleBtn(
                        iconButton: IconButton(
                            onPressed: () => setState(() {
                                  input += '3';
                                }),
                            icon: const MyIcon(iconLabel: '3'))),
                    CircleAvatar(
                      backgroundColor: color.inversePrimary,
                      radius: size.shortestSide / 11,
                      child: SizedBox(
                        height: size.longestSide,
                        width: size.longestSide,
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
                      backgroundColor: color.inversePrimary,
                      radius: size.shortestSide / 11,
                      child: SizedBox(
                          height: size.longestSide,
                          width: size.longestSide,
                          child: IconButton(
                              onPressed: () => setState(() {
                                    input += '/100';
                                  }),
                              icon: const Icon(Icons.percent))),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleBtn(
                        iconButton: IconButton(
                            onPressed: () => setState(() {
                                  input += '00';
                                }),
                            icon: const MyIcon(iconLabel: '00'))),
                    CircleBtn(
                        iconButton: IconButton(
                            onPressed: () => setState(() {
                                  input += '0';
                                }),
                            icon: const MyIcon(iconLabel: '0'))),
                    CircleBtn(
                        iconButton: IconButton(
                            onPressed: () => setState(() {
                                  input += '.';
                                }),
                            icon: const MyIcon(iconLabel: '.'))),
                    CircleAvatar(
                      backgroundColor: color.inversePrimary,
                      radius: size.shortestSide / 11,
                      child: SizedBox(
                        height: size.longestSide,
                        width: size.longestSide,
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
                      backgroundColor: Colors.green,
                      radius: size.shortestSide / 11,
                      child: SizedBox(
                          height: size.longestSide,
                          width: size.longestSide,
                          child: IconButton(
                              onPressed: () {
                                if (input.isNotEmpty) {
                                  setState(() {
                                    Expression exp =
                                        Parser().parse(finalUserInput);
                                    double eval = exp.evaluate(
                                        EvaluationType.REAL, ContextModel());
                                    answer = eval.toString();
                                    if (answer.endsWith('.0')) {
                                      answer = answer.substring(
                                          0, answer.length - 2);
                                    }
                                  });
                                  _addItem();
                                }
                              },
                              icon: const Text(
                                '=',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ))),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
