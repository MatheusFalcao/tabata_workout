import 'dart:async';

import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  int _currentRound = 1;
  int _rounds = 0;
  int _restTime = 0;
  int _timeLeft = 0;

  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timeLeft = _restTime;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeLeft -= 1;
      });
      if (_timeLeft == 0) {
        timer.cancel();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Round Completed'),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('Next Round'),
                  onPressed: () {
                    setState(() {
                      _currentRound += 1;
                    });
                    if (_currentRound <= _rounds) {
                      startTimer();
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final Map<String, int> args =
    //     ModalRoute.of(context).settings.arguments as Map<String, int>;
    // _rounds = args['rounds'];
    // _restTime = args['restTime']!;
    _rounds = 3;
    _restTime = 15;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabata App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Round $_currentRound of $_rounds',
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 32.0),
            Text(
              '$_timeLeft seconds',
              style: const TextStyle(fontSize: 64.0),
            ),
            const SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    startTimer();
                  },
                  child: const Text('Start'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _timer.cancel();
                  },
                  child: const Text('Stop'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
