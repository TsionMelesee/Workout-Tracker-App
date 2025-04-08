import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import '../blocs/workout_bloc.dart';
import '../blocs/workout_state.dart';
import '../blocs/workout_event.dart';
import 'completion_screen.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  Timer? _timer;
  int _secondsLeft = 0;
  bool _isPaused = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer(int seconds, VoidCallback onComplete) {
    _secondsLeft = seconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        setState(() {
          if (_secondsLeft > 0) {
            _secondsLeft--;
          } else {
            timer.cancel();
            onComplete();
          }
        });
      }
    });
  }

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '00:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutBloc, WorkoutState>(
      builder: (context, state) {
        if (state is WorkoutInProgress) {
          final exercise = state.workout.exercises[state.currentExerciseIndex];
          // Start timer only if not already started
          if (_timer == null) {
            _startTimer(exercise.duration * 60, () {
              BlocProvider.of<WorkoutBloc>(context)
                  .add(CompleteExercise(exercise));
              if (state.currentExerciseIndex + 1 <
                  state.workout.exercises.length) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => ExerciseScreen()),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => CompletionScreen()),
                );
              }
            });
          }
          return Scaffold(
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 32),
                  CircleAvatar(
                    radius: 80,
                    backgroundImage:
                        AssetImage('assets/squat.jpg'), // Placeholder
                  ),
                  SizedBox(height: 24),
                  Text(
                    exercise.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    exercise.description,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 32),
                  Text(
                    _formatTime(_secondsLeft == 0
                        ? exercise.duration * 60
                        : _secondsLeft),
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 24),
                  IconButton(
                    icon: Icon(
                        _isPaused
                            ? Icons.play_circle_fill
                            : Icons.pause_circle_filled,
                        size: 48,
                        color: Colors.deepPurple),
                    onPressed: () {
                      setState(() {
                        _isPaused = !_isPaused;
                      });
                    },
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      _timer?.cancel();
                      BlocProvider.of<WorkoutBloc>(context)
                          .add(CompleteExercise(exercise));
                      if (state.currentExerciseIndex + 1 <
                          state.workout.exercises.length) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => ExerciseScreen()),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => CompletionScreen()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: StadiumBorder(),
                    ),
                    child: Text('Complete Exercise'),
                  ),
                ],
              ),
            ),
          );
        }
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
