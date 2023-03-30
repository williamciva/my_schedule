import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_schedule/models/class.dart';
import 'package:my_schedule/services/atitus_api.dart';

import 'confs/routes.dart';

class ListClasses extends StatefulWidget {
  const ListClasses({super.key});

  @override
  State<ListClasses> createState() => _ListClassesState();
}

class _ListClassesState extends State<ListClasses> {
  var classes = [
    MyClass(
        name: "Legislação",
        dayOfWeek: "Segunda-Feira",
        local: "Onlines",
        isFav: false),
    MyClass(
        name: "Games",
        dayOfWeek: "Terça-Feira",
        local: "Onlines",
        isFav: false),
    MyClass(
        name: "Banco de Dados",
        dayOfWeek: "Quarta-Feira",
        local: "Lab 1",
        isFav: false),
    MyClass(
        name: "Desafios da Tecnologia",
        dayOfWeek: "Quinta-Feira",
        local: "Onlines",
        isFav: false),
    MyClass(
        name: "Flutter", dayOfWeek: "Sexta-Feira", local: "Lab 5", isFav: false)
  ];

  Offset _tapPosition = Offset.zero;
  void _getTapPosition(TapDownDetails details) {
    GestureDetector(onTapDown: (details) {
      final tapPosition = details.globalPosition;
    });

    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = referenceBox.globalToLocal(details.globalPosition);
    });
  }

  void _showMenuOptionTab(MyClass myClass) {
    final RenderObject? overlay =
        Overlay.of(context)!.context.findRenderObject();

    showMenu(
        context: context,
        position: RelativeRect.fromRect(
            Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 30, 30),
            Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
                overlay.paintBounds.size.height)),
        items: [
          PopupMenuItem(
            value: 'Favoritar',
            child: myClass.isFav
                ? const Text('Remover dos Favoritos')
                : const Text('Adicionar aos Favoritos'),
          ),
          const PopupMenuItem(
            value: 'Remover',
            child: Text('Remover Cadeira'),
          ),
        ]).then((value) {
      switch (value) {
        case 'Favoritar':
          setState(() {
            myClass.isFav = !myClass.isFav;
          });
          break;
        case 'Remover':
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Remover Item'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(
                            'Você está prestes a remover a cadeira ${myClass.name}.'),
                        const Text('Deseja continuar?')
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                        child: const Text('Continuar'),
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).pop();
                            classes.remove(myClass);
                          });
                        }),
                    TextButton(
                        child: const Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ],
                );
              });
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (details) => _getTapPosition(details),
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Minhas aulas"),
              actions: [
                IconButton(
                    onPressed: () {
                      Future future =
                          Navigator.of(context).pushNamed(ADD_CLASS_PAGE);
                      future.then((myClass) {
                        if (myClass != null) {
                          setState(() {
                            classes.add(myClass);
                          });
                        }
                      });
                    },
                    icon: const Icon(Icons.add_circle_outline))
              ],
            ),
            body: ListView.separated(
                itemBuilder: (context, index) => buidItem(classes[index]),
                separatorBuilder: (context, index) => const Divider(
                      height: 1,
                    ),
                itemCount: classes.length)));
  }

  Widget buidItem(MyClass myClass) => ListTile(
      leading: myClass.isFav
          ? const Icon(Icons.favorite)
          : const Icon(Icons.favorite_border_outlined),
      title: Text(myClass.name),
      subtitle: Text(myClass.dayOfWeek),
      trailing: Text(myClass.local),
      onLongPress: () => _showMenuOptionTab(myClass),
      onTap: () => setState(() {
            dotenv.load().then((value) => AtitusApi(host: 'ava.atitus.edu.br')
                .login(
                    username: '1127637',
                    password: '${dotenv.env["PASSWORD"]}'));
            myClass.isFav = !myClass.isFav;
          }));
}
