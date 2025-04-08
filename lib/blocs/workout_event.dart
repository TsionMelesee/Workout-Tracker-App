import 'package:equatable/equatable.dart';
import '../models/workout.dart';
import '../models/exercise.dart';

abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();
  @override
  List<Object?> get props => [];
}

class StartWorkout extends WorkoutEvent {
  final Workout workout;
  const StartWorkout(this.workout);
  @override
  List<Object?> get props => [workout];
}

class CompleteExercise extends WorkoutEvent {
  final Exercise exercise;
  const CompleteExercise(this.exercise);
  @override
  List<Object?> get props => [exercise];
}

class RateExercise extends WorkoutEvent {
  final Exercise exercise;
  final int rating;
  const RateExercise(this.exercise, this.rating);
  @override
  List<Object?> get props => [exercise, rating];
}
