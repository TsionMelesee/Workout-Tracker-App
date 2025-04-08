import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/workout.dart';
import '../models/exercise.dart';
import '../blocs/workout_bloc.dart';
import '../blocs/workout_event.dart';
import 'exercise_screen.dart';

class HomeScreen extends StatelessWidget {
  final int dayIndex;
  HomeScreen({super.key, this.dayIndex = 0});

  final List<Workout> workouts = [
    Workout(
      title: 'Run Fast, Feel Free',
      author: 'Joean Assalam',
      duration: 40,
      calories: 630,
      exercises: [
        Exercise(
          name: 'Interval Sprints',
          description: 'Boost speed and endurance with sprints.',
          imagePath: '',
          duration: 20,
          calories: 315,
        ),
        Exercise(
          name: 'High Knees',
          description: 'Increase heart rate and leg strength.',
          imagePath: '',
          duration: 20,
          calories: 315,
        ),
      ],
    ),
    // Add more Workout objects for more days if needed
  ];

  @override
  Widget build(BuildContext context) {
    final workout =
        (dayIndex < workouts.length) ? workouts[dayIndex] : workouts[0];
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 32),
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/runner.avif'), // Placeholder
            ),
            SizedBox(height: 24),
            Text(
              workout.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              workout.author,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.timer, size: 20),
                SizedBox(width: 4),
                Text('${workout.duration} minutes'),
                SizedBox(width: 16),
                Icon(Icons.local_fire_department,
                    color: Colors.orange, size: 20),
                SizedBox(width: 4),
                Text('${workout.calories} kcal'),
              ],
            ),
            SizedBox(height: 24),
            Text('Day ${dayIndex + 1}',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold)),
            Text(
                '${workout.exercises.length} Exercise  •  ${workout.duration} minutes'),
            SizedBox(height: 24),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/runner.avif'), // Placeholder
                ),
                title: Text(workout.exercises[0].name),
                subtitle: Text(workout.exercises[0].description),
                trailing: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<WorkoutBloc>(context)
                        .add(StartWorkout(workout));
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ExerciseScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: StadiumBorder(),
                  ),
                  child: Text('Start'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
