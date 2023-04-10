import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
  String _nextExercise = '';
  int _exerciseIndex = 0;
  int _exerciseTotal = 0;
  double _percent = 1.0;

  late Timer _timer;
  Color _bg = Colors.green;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();

    // Initialize the first exercise and prepare time
    List exercises = widget.exercises;
    _currentExercise = exercises[0].trim();
    _currentTime = widget.prepareTime;
    _nextExercise = exercises[1].trim();
    _exerciseTotal = exercises.length;
    // Start the timer
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (!_isPaused) {
          _currentTime--;
        }

        if (_isPreparing) {
          _percent = (_currentTime * 100 / widget.prepareTime) / 100;
        } else if (_isWorkTime) {
          _percent = (_currentTime * 100 / widget.workTime) / 100;
        } else {
          _percent = (_currentTime * 100 / widget.restTime) / 100;
        }

        if (_currentTime > 0) {
          if (_currentTime < 5) {
            _bg = Colors.red;
          }
          //
          // If there is still time left, decrement the timer
          // _currentTime--;
        } else {
          _percent = 1.0;
          // If the current time is zero, switch to the next exercise/round
          if (_isPreparing) {
            // If we were in the preparation phase, switch to the first exercise
            List exercises = widget.exercises;
            _currentExercise = exercises[0].trim();
            _currentTime = widget.workTime;
            _isPreparing = false;
            _bg = Colors.lightBlueAccent;
            _exerciseIndex++;
          } else if (_isWorkTime) {
            // If we were in the work phase, switch to the rest phase
            // _currentExercise = 'Rest';
            _currentTime = widget.restTime;
            _isWorkTime = false;
            _bg = const Color.fromARGB(255, 119, 88, 231);
          } else {
            // If we were in the rest phase, switch to the next exercise
            List exercises = widget.exercises;
            int currentExerciseIndex = exercises.indexOf(_currentExercise);

            print("DEBUG: currentExerciseIndex: $currentExerciseIndex");
            print("DEBUG: _exerciseTotal: $_exerciseTotal");
            if (currentExerciseIndex == exercises.length - 1) {
              // If we reached the last exercise, go back to the first exercise and increment the round
              _currentExercise = exercises[0].trim();
              _currentTime = widget.workTime;
              _isWorkTime = true;
              _isPreparing = true;
              _currentRound++;
              _bg = Colors.lightBlueAccent;
              _exerciseIndex = 0;
              _nextExercise = 'Done!';
              if (_currentRound > widget.rounds) {
                print('ACABOU O ULTIMO ROUND');
                Navigator.pop(context);
                return;
              }
            } else {
              // Otherwise, switch to the next exercise
              _currentExercise = exercises[currentExerciseIndex + 1].trim();
              if (_exerciseIndex + 1 == _exerciseTotal) {
                _nextExercise = 'Done';
              } else {
                _nextExercise = exercises[currentExerciseIndex + 2].trim();
              }

              print("DEBUG: _exerciseIndex: $_exerciseIndex");
              _currentTime = widget.workTime;
              _isWorkTime = true;
              _isPreparing = false;
              _exerciseIndex++;
              _bg = Colors.lightBlueAccent;
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
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.sports_gymnastics,
                          color: Colors.white,
                        ),
                        const Text(
                          'Work',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${widget.workTime}s',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.timer,
                          color: Colors.white,
                        ),
                        const Text(
                          'Rest',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${widget.restTime}s',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.repeat_one,
                          color: Colors.white,
                        ),
                        const Text(
                          'Rounds',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${widget.rounds}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Exercicio $_exerciseIndex / $_exerciseTotal',
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _isPreparing
                    ? 'Preparar'
                    : _isWorkTime
                        ? _currentExercise
                        : 'Rest',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              CircularPercentIndicator(
                radius: 180,
                lineWidth: 30,
                percent: _percent,
                progressColor:
                    _currentTime > 5 ? Colors.green[300] : Colors.red[300],
                backgroundColor: Colors.white70,
                circularStrokeCap: CircularStrokeCap.round,
                animation: true,
                animateFromLastPercent: true,
                center: Text(
                  '$_currentTime',
                  style: const TextStyle(
                      fontSize: 180,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                            // bottomLeft
                            offset: Offset(-1.5, -1.5),
                            color: Colors.white),
                        Shadow(
                            // bottomRight
                            offset: Offset(1.5, -1.5),
                            color: Colors.white),
                        Shadow(
                            // topRight
                            offset: Offset(1.5, 1.5),
                            color: Colors.white),
                        Shadow(
                            // topLeft
                            offset: Offset(-1.5, 1.5),
                            color: Colors.white),
                      ]),
                ),
              ),

              const SizedBox(height: 12),
              Text(
                _isPreparing
                    ? _currentExercise
                    : _isWorkTime
                        ? 'Rest'
                        : _nextExercise,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Row(
              //   children: [
              //     Expanded(
              //       child: ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: Colors.red,
              //           padding: const EdgeInsets.all(20),
              //         ),
              //         child: const Text(
              //           'Cancel',
              //           style: TextStyle(fontSize: 18),
              //         ),
              //         onPressed: () {
              //           Navigator.pop(context);
              //         },
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _togglePause();
        },
        backgroundColor: Colors.blue,
        child:
            _isPaused ? const Icon(Icons.play_arrow) : const Icon(Icons.pause),
      ),
    );
  }
}
