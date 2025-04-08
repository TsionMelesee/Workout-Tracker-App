import 'package:equatable/equatable.dart';
import '../models/workout.dart';
import '../models/exercise.dart';

abstract class WorkoutState extends Equatable {
  const WorkoutState();
  @override
  List<Object?> get props => [];
}

class WorkoutInitial extends WorkoutState {}

class WorkoutInProgress extends WorkoutState {
  final Workout workout;
  final int currentExerciseIndex;
  const WorkoutInProgress(this.workout, this.currentExerciseIndex);
  @override
  List<Object?> get props => [workout, currentExerciseIndex];
}

class WorkoutCompleted extends WorkoutState {
  final Workout workout;
  final int totalMinutes;
  final int totalCalories;
  const WorkoutCompleted(this.workout, this.totalMinutes, this.totalCalories);
  @override
  List<Object?> get props => [workout, totalMinutes, totalCalories];
}

class ExerciseRated extends WorkoutState {
  final Exercise exercise;
  final int rating;
  const ExerciseRated(this.exercise, this.rating);
  @override
  List<Object?> get props => [exercise, rating];
}
