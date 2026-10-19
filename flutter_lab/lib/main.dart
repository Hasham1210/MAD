// main.dart - Study Tracker lab
// import 'dart:async';

import 'package:flutter/material.dart';

const String studentName = 'Raja Hasham Ahmed';
const String rollNo = '04072313006'; // e.g. '21F-0347'

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> courses = [
  'Mobile Dev',
  'Data Structures',
  'Operating Systems',
  'Databases',
  'Networks',
  'Software Eng',
  'AI',
  'Web Engineering',
  'Graphics',
  'Security',
];

final String course = courses[u]; // your course name
final int startCount = 3 + u; // where the tally starts
final int stepSize = 1 + t % 4; // how much + and - change the tally
final int maxCount = 20 + 2 * t; // the tally may never go above this
final int startSeconds = 5 + (t + u) % 6; // where the countdown starts
final int bugStep = 1 + u % 4; // used by BuggyCounter in Step 7
// ===========================================================================

// Step 9 writes to this list from initState and dispose.
final List<String> lifecycleLog = <String>[];

void main() => runApp(const LabApp());

// Keep the name LabApp and its const constructor: the checker uses them.

class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    // runApp receives the root widget, LabApp.
    // MaterialApp receives the app configuration, including home.
    return const MaterialApp(title: 'Study Tracker', home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Study Tracker: $course')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StudentCard(name: studentName, roll: rollNo, course: course),
            const SizedBox(height: 12),

            // Row displays the seeded information horizontally.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Start: $startCount', key: const Key('info-start')),
                Text('Step: $stepSize', key: const Key('info-step')),
                Text('Max: $maxCount', key: const Key('info-max')),
              ],
            ),
            const SizedBox(height: 12),

            GoalBanner(count: startCount, max: maxCount),
          ],
        ),
      ),
    );
  }
}
// Q:--Step## 03:
// Draw the widget tree from LabApp to Text('Max: ...').
//
// A: LabApp -> MaterialApp -> HomePage -> Scaffold ->
// SingleChildScrollView -> Column -> Row -> Text('Max: ...').
// Text('Max: ...') is 7 parent-child edges below LabApp.

// Stateless: displays student information passed to it.
class StudentCard extends StatelessWidget {
  final String name;
  final String roll;
  final String course;

  const StudentCard({
    super.key,
    required this.name,
    required this.roll,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $name', key: const Key('student-name')),
            Text('Roll no: $roll', key: const Key('student-roll')),
            Text('Course: $course', key: const Key('student-course')),
          ],
        ),
      ),
    );
  }
}
//Q: step 1:
// Ans::: runApp receives widget (LabApp) while MaterialApp's home specifies
// the widget displayed as the main screen (HomePage).

//Step:: 2
// Q--: Why are the fields of a StatelessWidget final?
// A: They hold the widget's configuration and cannot be reassigned after initialization.

///Step::2
// Q--: What happens if final is removed?
// A: The fields become mutable

// --->>Step 4:
class GoalBanner extends StatelessWidget {
  final int count;
  final int max;

  const GoalBanner({super.key, required this.count, required this.max});

  @override
  Widget build(BuildContext context) {
    final percent = count * 100 ~/ max;

    return Text(
      'Progress: $count of $max ($percent%)',
      key: const Key('progress'),
    );
  }
}

// Step: 4--Q: Why does GoalBanner not need setState?

// A: It is a StatelessWidget. It displays the count and max
// passed to it without maintaining changing state of its own.
//
// Q: What would you do to show a new count?
// A: Pass the updated count to GoalBanner from a parent widget that rebuilds when the count changes.
