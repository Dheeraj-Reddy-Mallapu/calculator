import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';
import 'sqlite.dart';

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
    final TextEditingController inp = TextEditingController(text: input);
    String finalUserInp = input;
    finalUserInp = input.replaceAll('x', '*');
    String finalUserInput = finalUserInp.replaceAll('√', 'sqrt');

    final TextEditingController out = TextEditingController(text: answer);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        title: Text(
          'CALCULATOR',
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
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
                                input = _journals[idx]['que'];
                                answer = _journals[idx]['ans'];
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
                                  _deleteItem(_journals[idx]['que']);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Deleted')));
                                }));
                      }))),
              icon: const Icon(Icons.history))
        ],
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
              const SizedBox(height: 15),
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
        ),
        const SizedBox(height: 10),
        Container(
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.tertiaryContainer,
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
                    backgroundColor:
                        Theme.of(context).colorScheme.tertiaryContainer,
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
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
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
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    radius: MediaQuery.of(context).size.shortestSide / 12,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.longestSide,
                      width: MediaQuery.of(context).size.longestSide,
                      child: IconButton(
                          onPressed: () => setState(() {
                                input += '√';
                              }),
                          icon: const Text(
                            '√',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          )),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.error,
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
                          icon: const Icon(Icons.backspace),
                          color: Theme.of(context).colorScheme.onError,
                        )),
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
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
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
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
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
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
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
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
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
                    backgroundColor: Theme.of(context).colorScheme.error,
                    radius: MediaQuery.of(context).size.shortestSide / 12,
                    child: SizedBox(
                        height: MediaQuery.of(context).size.longestSide,
                        width: MediaQuery.of(context).size.longestSide,
                        child: IconButton(
                          onPressed: () => setState(() {
                            input = '';
                            answer = '';
                          }),
                          icon: Icon(Icons.delete,
                              color: Theme.of(context).colorScheme.onError),
                        )),
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
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
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
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
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
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
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
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
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
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
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
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
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
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
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
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
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
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
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
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
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
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
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
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
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
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
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
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
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
                    backgroundColor: Colors.green,
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
                                  if (answer.endsWith('.0')) {
                                    answer =
                                        answer.substring(0, answer.length - 2);
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
              const SizedBox(height: 10),
            ],
          ),
        )
      ]),
    );
  }
}
