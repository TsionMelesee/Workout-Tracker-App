import 'package:flutter_bloc/flutter_bloc.dart';
import 'workout_event.dart';
import 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  WorkoutBloc() : super(WorkoutInitial()) {
    on<StartWorkout>((event, emit) {
      emit(WorkoutInProgress(event.workout, 0));
    });
    on<CompleteExercise>((event, emit) {
      if (state is WorkoutInProgress) {
        final currentState = state as WorkoutInProgress;
        final nextIndex = currentState.currentExerciseIndex + 1;
        if (nextIndex < currentState.workout.exercises.length) {
          emit(WorkoutInProgress(currentState.workout, nextIndex));
        } else {
          // Calculate total minutes and calories
          final totalMinutes = currentState.workout.exercises
              .fold(0, (sum, e) => sum + e.duration);
          final totalCalories = currentState.workout.exercises
              .fold(0, (sum, e) => sum + e.calories);
          emit(WorkoutCompleted(
              currentState.workout, totalMinutes, totalCalories));
        }
      }
    });
    on<RateExercise>((event, emit) {
      emit(ExerciseRated(event.exercise, event.rating));
    });
  }
}
