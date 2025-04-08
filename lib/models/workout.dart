// Workout model
import 'exercise.dart';

class Workout {
  final String title;
  final String author;
  final int duration; // in minutes
  final int calories;
  final List<Exercise> exercises;

  Workout({
    required this.title,
    required this.author,
    required this.duration,
    required this.calories,
    required this.exercises,
  });
}
