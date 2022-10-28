import 'dart:html';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fx99 Calculator',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const SimpleCalc(),
    );
  }
}

class SimpleCalc extends StatefulWidget {
  const SimpleCalc({Key? key}) : super(key: key);

  @override
  _SimpleCalcState createState() => _SimpleCalcState();
}

class _SimpleCalcState extends State<SimpleCalc> {
  String eqtn = '0';
  String result = '0';
  String expression = '0';
  double eqtnFtSize = 38.0;
  double resultFtSize = 48.0;

  buttonPressed(String btnText) {
    setState(() {
      if (btnText == 'C') {
        eqtnFtSize = 38.0;
        resultFtSize = 48.0;
        eqtn = '0';
        result = '0';
      } else if (btnText == 'Del') {
        eqtnFtSize = 48.0;
        resultFtSize = 38.0;
        eqtn = eqtn.substring(0, eqtn.length - 1);
        if (eqtn == '') {
          eqtn = '0';
        }
      } else if (btnText == '=') {
        eqtnFtSize = 38.0;
        resultFtSize = 48.0;
        expression = eqtn;
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('×', '*');
        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'Error';
        }
      } else {
        eqtnFtSize = 48.0;
        resultFtSize = 38.0;
        if (eqtn == '0') {
          eqtn = btnText;
        } else {
          eqtn = eqtn + btnText;
        }
      }
    });
  }

  Widget buildButton(String btnText, double btnHeit, Color btnCol) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * btnHeit,
      color: btnCol,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: const BorderSide(
              color: Colors.white,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
        ),
        //padding: EdgeInsets.all(16.0),
        onPressed: () => buttonPressed(btnText),
        child: Text(
          btnText,
          style: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fx99 Calculator'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              eqtn,
              style: TextStyle(fontSize: eqtnFtSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFtSize),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("C", 1, Colors.redAccent),
                        buildButton("Del", 1, Colors.blue),
                        buildButton("÷", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("7", 1, Colors.black54),
                        buildButton("8", 1, Colors.black54),
                        buildButton("9", 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("4", 1, Colors.black54),
                        buildButton("5", 1, Colors.black54),
                        buildButton("6", 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("1", 1, Colors.black54),
                        buildButton("2", 1, Colors.black54),
                        buildButton("3", 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton(".", 1, Colors.black54),
                        buildButton("0", 1, Colors.black54),
                        buildButton("00", 1, Colors.black54),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("×", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("-", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("+", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("=", 2, Colors.blue),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
