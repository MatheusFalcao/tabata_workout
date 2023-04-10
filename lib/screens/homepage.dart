import 'package:flutter/material.dart';
import 'package:tabata_workout/screens/second_screen.dart';

import '../widgets/list_item.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key, required this.title});

  final String title;

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final TextEditingController exerciseController = TextEditingController();
  final TextEditingController roundsController = TextEditingController();
  final TextEditingController workController = TextEditingController();
  final TextEditingController restController = TextEditingController();
  final TextEditingController prepareController = TextEditingController();
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
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Olá, 😄',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const Text(
                'Como vai ser o treino hoje? 💪',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: workController,
                      decoration: const InputDecoration(
                          hintText: '60',
                          suffix: Text('seg'),
                          prefixIcon: Icon(Icons.timer),
                          labelText: 'Work',
                          border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: restController,
                      decoration: const InputDecoration(
                          hintText: '15',
                          suffix: Text('seg'),
                          prefixIcon: Icon(Icons.timer),
                          labelText: 'Descanço',
                          border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: roundsController,
                      decoration: const InputDecoration(
                          hintText: '3',
                          prefixIcon: Icon(Icons.repeat_one),
                          labelText: 'Rounds',
                          border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: prepareController,
                      decoration: const InputDecoration(
                          hintText: '10',
                          prefixIcon: Icon(Icons.timer),
                          labelText: 'Preparaçao',
                          border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            const Text(
                              'Exercicios',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
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
                                    // Navigator.pushNamed(context, '/secondScreen');
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
                                    for (var i = 0; i < exercises.length; i++)
                                      ListItem(
                                        title: exercises[i].toString(),
                                        index: i + 1,
                                      ),
                                    // exercises.asMap().forEach(
                                    //       (index, value) =>
                                    //           ListItem(title: value.toString()),
                                    //     ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SecondScreen(
                rounds: int.parse(roundsController.text),
                prepareTime: int.parse(prepareController.text),
                workTime: int.parse(workController.text),
                restTime: int.parse(restController.text),
                exercises: exercises,
              ),
            ));
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.play_arrow)),
    );
  }
}
