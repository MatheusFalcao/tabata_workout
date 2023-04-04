import 'dart:async';
import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  final int rounds;
  final int restTime;
  final int workTime;
  final int prepareTime;
  final List exercises;

  const SecondScreen({
    super.key,
    required this.rounds,
    required this.restTime,
    required this.workTime,
    required this.prepareTime,
    required this.exercises,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  int _currentRound = 1;
  bool _isWorkTime = true;
  bool _isPreparing = true;
  int _currentTime = 0;
  String _currentExercise = '';
  late Timer _timer;
  Color _bg = Colors.green;

  @override
  void initState() {
    super.initState();

    // Initialize the first exercise and prepare time
    List exercises = widget.exercises;
    _currentExercise = exercises[0].trim();
    _currentTime = widget.prepareTime;

    // Start the timer
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentTime > 0) {
          // If there is still time left, decrement the timer
          _currentTime--;
        } else {
          // If the current time is zero, switch to the next exercise/round
          if (_isPreparing) {
            // If we were in the preparation phase, switch to the first exercise
            List exercises = widget.exercises;
            _currentExercise = exercises[0].trim();
            _currentTime = widget.workTime;
            _isPreparing = false;
            _bg = Colors.lightBlueAccent;
            print('debug 1');
          } else if (_isWorkTime) {
            // If we were in the work phase, switch to the rest phase
            // _currentExercise = 'Rest';
            _currentTime = widget.restTime;
            _isWorkTime = false;
            _bg = const Color.fromARGB(255, 54, 9, 214);
            print('debug 2');
          } else {
            // If we were in the rest phase, switch to the next exercise
            List exercises = widget.exercises;
            int currentExerciseIndex = exercises.indexOf(_currentExercise);
            print('debug 3 - exerciseIndex: $currentExerciseIndex');
            print('debug 3 - exercise : $_currentExercise');
            if (currentExerciseIndex == exercises.length - 1) {
              // If we reached the last exercise, go back to the first exercise and increment the round
              _currentExercise = exercises[0].trim();
              _currentTime = widget.workTime;
              _isWorkTime = true;
              _isPreparing = true;
              _currentRound++;
              _bg = Colors.lightBlueAccent;
              print('debug 4');
              if (_currentRound > widget.rounds) {
                print('ACABOU O ULTIMO ROUND');
                Navigator.pop(context);
                return;
              }
            } else {
              // Otherwise, switch to the next exercise
              _currentExercise = exercises[currentExerciseIndex + 1].trim();
              _currentTime = widget.workTime;
              _isWorkTime = true;
              _isPreparing = false;
              _bg = Colors.lightBlueAccent;
              print('debug 5 - exercise : $_currentExercise');
            }
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabata App'),
        backgroundColor: _bg,
      ),
      body: Container(
        color: _bg,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Round $_currentRound',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 16),
              Text(
                _isPreparing
                    ? 'Preparar'
                    : _isWorkTime
                        ? _currentExercise
                        : 'Rest',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '$_currentTime',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Work: ${widget.workTime}s ',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Rest: ${widget.restTime}s ',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Rounds: ${widget.rounds}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
