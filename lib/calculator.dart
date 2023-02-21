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

  btnState(val) {
    setState(() {
      input += val;
    });
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
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pasted')));
                            },
                            leading: CircleAvatar(child: Text('${revIdx + 1}')),
                            title: Text('${_journals[revIdx]['que']}'),
                            subtitle: Text('${_journals[revIdx]['ans']}'),
                            trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _deleteItem(_journals[revIdx]['que']);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Deleted')));
                                }));
                      }))),
              icon: const Icon(Icons.history))
        ],
      ),
      body: Column(children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: TextField(
                autofocus: true,
                style: const TextStyle(fontSize: 40),
                minLines: 2,
                maxLines: 2,
                controller: out,
                readOnly: true,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: TextField(
                style: const TextStyle(fontSize: 30),
                minLines: 1,
                maxLines: 2,
                controller: inp,
                readOnly: true,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            color: color.secondaryContainer,
            child: Column(
              children: [
                FlipCard(
                  direction: FlipDirection.VERTICAL,
                  front: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconBtn(iconBtnState: btnState, iconLabel: '('),
                      IconBtn(iconBtnState: btnState, iconLabel: ')'),
                      IconBtn(iconBtnState: btnState, iconLabel: '^'),
                      IconBtn(iconBtnState: btnState, iconLabel: '!'),
                      IconBtn(iconBtnState: btnState, iconLabel: '√'),
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
                      IconBtn(iconBtnState: btnState, iconLabel: 'log'),
                      IconBtn(iconBtnState: btnState, iconLabel: 'cos'),
                      IconBtn(iconBtnState: btnState, iconLabel: 'sin'),
                      IconBtn(iconBtnState: btnState, iconLabel: 'tan'),
                      IconButton(
                          onPressed: () => setState(() {
                                input += 'nrt';
                              }),
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
                            circleBtnState: btnState,
                            iconLabel: '7',
                            color: color.onSecondary,
                          ),
                          CircleBtn(
                            circleBtnState: btnState,
                            iconLabel: '8',
                            color: color.onSecondary,
                          ),
                          CircleBtn(
                            circleBtnState: btnState,
                            iconLabel: '9',
                            color: color.onSecondary,
                          ),
                          CircleBtn(
                            circleBtnState: btnState,
                            iconLabel: '/',
                            color: color.inversePrimary,
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
                                    input = input.substring(0, input.toString().length - 1);
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
                            circleBtnState: btnState,
                            iconLabel: '4',
                            color: color.onSecondary,
                          ),
                          CircleBtn(
                            circleBtnState: btnState,
                            iconLabel: '5',
                            color: color.onSecondary,
                          ),
                          CircleBtn(
                            circleBtnState: btnState,
                            iconLabel: '6',
                            color: color.onSecondary,
                          ),
                          CircleBtn(
                            circleBtnState: btnState,
                            iconLabel: 'x',
                            color: color.inversePrimary,
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
                            circleBtnState: btnState,
                            iconLabel: '1',
                            color: color.onSecondary,
                          ),
                          CircleBtn(
                            circleBtnState: btnState,
                            iconLabel: '2',
                            color: color.onSecondary,
                          ),
                          CircleBtn(
                            circleBtnState: btnState,
                            iconLabel: '3',
                            color: color.onSecondary,
                          ),
                          CircleBtn(
                            circleBtnState: btnState,
                            iconLabel: '-',
                            color: color.inversePrimary,
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
                            circleBtnState: btnState,
                            iconLabel: '00',
                            color: color.onSecondary,
                          ),
                          CircleBtn(
                            circleBtnState: btnState,
                            iconLabel: '0',
                            color: color.onSecondary,
                          ),
                          CircleBtn(
                            circleBtnState: btnState,
                            iconLabel: '.',
                            color: color.onSecondary,
                          ),
                          CircleBtn(
                            circleBtnState: btnState,
                            iconLabel: '+',
                            color: color.inversePrimary,
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
                                          Expression exp = Parser().parse(finalUserInput);
                                          double eval = exp.evaluate(EvaluationType.REAL, ContextModel());
                                          answer = eval.toString();
                                          if (answer.endsWith('.0')) {
                                            answer = answer.substring(0, answer.length - 2);
                                          }
                                        });
                                        _addItem();
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
          ),
        )
      ]),
    );
  }
}
