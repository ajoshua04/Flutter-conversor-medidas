// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<String> _measures = [
    'metros',
    'kilometros',
    'gramos',
    'kilogramos',
    'pies',
    'millas',
    'libras',
    'onzas'
  ];

  late String startM;
  late String endM;

  String endValue = "0";

  late int _startI;
  late int _endI;

  final _formulas = [
    [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    [0, 0, 1, 0.0001, 0, 0, 0, 0022, 0.035274],
    [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    [0, 0, 28.3495, 0, 02835, 3.28084, 0, 0.0625, 1],
  ];

  final valueController = TextEditingController();

  @override
  void initState() {
    _startI = 0;
    _endI = 1;

    startM = _measures[_startI];
    endM = _measures[_endI];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(color: Colors.blueGrey, fontSize: 20);
    final measureStyle = TextStyle(color: Colors.blue[700], fontSize: 20);

    var data = _measures.map((m) {
      return DropdownMenuItem(
          value: m,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              m,
              style: measureStyle,
            ),
          ));
    });

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Medidor"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              Text(
                "Valor",
                style: labelStyle,
              ),
              TextField(
                controller: valueController,
                decoration: const InputDecoration(
                    hintText: "Valor Inicial",
                    contentPadding: EdgeInsets.all(10)),
                onChanged: (value) {
                  // ignore: avoid_print
                  print(value);
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "De",
                style: labelStyle,
              ),
              const SizedBox(
                height: 8,
              ),
              DropdownButton<String>(
                  isExpanded: true,
                  value: startM,
                  items: data.toList(),
                  onChanged: (value) {
                    setState(() {
                      startM = value!;
                      _startI = _measures.indexOf(startM);
                    });
                  }),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Para",
                style: labelStyle,
              ),
              const SizedBox(
                height: 8,
              ),
              DropdownButton<String>(
                  isExpanded: true,
                  value: endM,
                  items: data.toList(),
                  onChanged: (value) {
                    setState(() {
                      endM = value!;
                      _endI = _measures.indexOf(endM);
                    });
                  }),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                  onPressed: () {
                    try {
                      // obtenemos el valor del usuario
                      final value = double.parse(valueController.text.trim());

                      setState(() {
                        // aplicamos los calculos
                        this.endValue = "${value * _formulas[_startI][_endI]}";
                      });

                      //FocusScope.of(context).unfocus();
                      // ocultar teclado
                      FocusScope.of(context).requestFocus(FocusNode());
                    } catch (e) {
                      print("Problemas con la conversión");
                    }
                  },
                  child: Text('Convertir')),
              const SizedBox(
                height: 20,
              ),
              Text("res: $endValue", style: labelStyle),
            ]),
          ),
        ),
      ),
    );
  }
}
