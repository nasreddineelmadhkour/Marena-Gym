import 'dart:async';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:percent_indicator/circular_percent_indicator.dart';

class ExercisePage extends StatefulWidget {
  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  Map<String, Stopwatch> stopwatches = {
    'Squat': Stopwatch(),
    'Pompes': Stopwatch(),
    'Crunch': Stopwatch(),
    'Mountain Climber': Stopwatch(),
    'Burpees': Stopwatch(),
  };

  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => setState(() {}));
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Exercices',
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var entry in stopwatches.entries)
                ExerciseCard(
                  title: entry.key,
                  stopwatch: entry.value,
                  onToggle: () {
                    setState(() {
                      if (entry.value.isRunning) {
                        entry.value.stop();
                      } else {
                        entry.value.start();
                      }
                    });
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExerciseCard extends StatelessWidget {
  final String title;
  final Stopwatch stopwatch;
  final VoidCallback onToggle;

  const ExerciseCard({
    Key? key,
    required this.title,
    required this.stopwatch,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 10.0,
              percent: stopwatch.elapsed.inSeconds / 60 / 10, // 10 minutes
              center: Text(
                '${stopwatch.elapsed.inMinutes}:${(stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}',
                style: TextStyle(fontSize: 20),
              ),
              progressColor: Colors.orange,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            IconButton(
              icon: Icon(
                stopwatch.isRunning ? Icons.pause : Icons.play_arrow,
              ),
              onPressed: onToggle,
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ExercisePage(),
  ));
}
