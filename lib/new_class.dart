import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:my_schedule/models/class.dart';

class NewClass extends StatefulWidget {
  const NewClass({super.key});

  @override
  State<NewClass> createState() => _NewClassState();
}

class _NewClassState extends State<NewClass> {
  static List<String> daysOfWeek = [
    "Segunda-Feira",
    "Terça-Feira",
    "Quarta-Feira",
    "Quinta-Feira",
    "Sexta-Feira",
    "Sábado"
  ];

  late String dropdownValue;

  _NewClassState() : dropdownValue = daysOfWeek[0];

  final _nomeController = TextEditingController();
  final _localController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova aula"),
        actions: [
          IconButton(
              onPressed: () {
                MyClass myClass = MyClass(
                    name: _nomeController.text,
                    dayOfWeek: dropdownValue,
                    local: _localController.text,
                    isFav: false);
                    Navigator.pop(context, myClass);
              },
              icon: const Icon(Icons.save_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          TextFormField(
            controller: _nomeController,
            validator: (value) => value == null || value.isEmpty
                ? 'Por Favor Infome um texto.'
                : null,
            decoration: const InputDecoration(
              labelText: 'Nome',
              //errorText: 'Informe o nome da aula',
              border: OutlineInputBorder(),
              /*suffixIcon: Icon(
                Icons.error,
              ),*/
            ),
          ),
          TextFormField(
            controller: _localController,
            validator: (value) => value == null || value.isEmpty
                ? 'Por Favor Infome um Local.'
                : null,
            decoration: const InputDecoration(
              labelText: 'Local',
              //errorText: 'Informe o nome da aula',
              border: OutlineInputBorder(),
              /*suffixIcon: Icon(
                Icons.error,
              ),*/
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          DropdownButton(
            icon: const Icon(Icons.calendar_today),
            isExpanded: true,
            value: dropdownValue,
            items: buildListItens(),
            onChanged: (value) {
              setState(() {
                dropdownValue = value;
              });
            },
          ),
        ]),
      ),
    );
  }

  List<DropdownMenuItem> buildListItens() => List.generate(
      6,
      (index) => DropdownMenuItem(
            value: daysOfWeek[index],
            child: Text(daysOfWeek[index]),
          ));
}
