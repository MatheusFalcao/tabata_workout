import 'package:flutter/material.dart';

import '../widgets/list_item.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key, required this.title});

  final String title;

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final TextEditingController exerciseController = TextEditingController();

  List<String> exercises = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SafeArea(
          child: Column(
        children: [
          const Text(
            'Olá,',
            style: TextStyle(color: Colors.black),
          ),
          const Text(
            'Como vai ser o treino hoje?',
            style: TextStyle(color: Colors.blue),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: '60',
                        suffix: Text('seg'),
                        prefixIcon: Icon(Icons.timer),
                        labelText: 'Exercício',
                        border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: '15',
                        suffix: Text('seg'),
                        prefixIcon: Icon(Icons.timer),
                        labelText: 'Descanço',
                        border: OutlineInputBorder()),
                  ),
                ),
                // ElevatedButton(
                //     onPressed: () {
                //       Navigator.pushNamed(context, '/teste');
                //     },
                //     child: const Text('teste de nav')
                // )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: '3',
                        prefixIcon: Icon(Icons.repeat_one),
                        labelText: 'Rounds',
                        border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: '10',
                        suffix: Text('seg'),
                        prefixIcon: Icon(Icons.timer),
                        labelText: 'Preparaçao',
                        border: OutlineInputBorder()),
                  ),
                ),
                // Expanded(
                //   child: TextField(
                //     decoration: InputDecoration(
                //         hintText: '15',
                //         prefixIcon: Icon(Icons.sports_gymnastics_outlined),
                //         labelText: 'Quantidade de Exercicíos',
                //         border: OutlineInputBorder()),
                //   ),
                // ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        const Text('Exercicios'),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: TextField(
                              controller: exerciseController,
                              decoration: const InputDecoration(
                                labelText: 'Nome do Exercicío',
                                border: OutlineInputBorder(),
                              ),
                            )),
                            const SizedBox(
                              width: 25,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                String text = exerciseController.text;
                                setState(() {
                                  exercises.add(text);
                                });
                                exerciseController.clear();
                                Navigator.pushNamed(context, '/secondScreen');
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(20)),
                              child: const Icon(Icons.add),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Flexible(
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                for (String exercise in exercises)
                                  const ListItem(),
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
                Expanded(
                    flex: 2,
                    child: Column(
                      children: const [
                        Text(
                          'Atletas',
                          style: TextStyle(color: Colors.blue, fontSize: 10),
                        ),
                      ],
                    ))
              ],
            ),
          )
        ],
      )),
    );
  }
}
