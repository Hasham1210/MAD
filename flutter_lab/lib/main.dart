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

            // Step 5: Tally manages its own changing count.
            const Tally(),
            const SizedBox(height: 12),

            // Step 7: Demonstrates the missing setState bug.
            const BuggyCounter(),
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

// Step 5: Stateful widget configuration.
class Tally extends StatefulWidget {
  const Tally({super.key});

  @override
  State<Tally> createState() => _TallyState();
}

// Step 5: State object stores and updates the changing count.
class _TallyState extends State<Tally> {
  int _count = startCount;

  // TASK 6.1: Increase the count without exceeding maxCount.
  void _plus() {
    setState(() {
      _count += stepSize;

      // Do not allow the count to exceed maxCount.
      if (_count > maxCount) {
        _count = maxCount;
      }
    });
  }

  // TASK 6.2: Decrease the count without going below zero.
  void _minus() {
    setState(() {
      _count -= stepSize;

      if (_count < 0) {
        _count = 0;
      }
    });
  }

  // TASK 6.2: Restore the original count.
  void _reset() {
    setState(() {
      _count = startCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Count: $_count', key: const Key('count')),
        GoalBanner(count: _count, max: maxCount),
        Row(
          children: [
            ElevatedButton(
              key: const Key('plus'),
              onPressed: _plus,
              child: Text('+$stepSize'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              key: const Key('minus'),
              onPressed: _minus,
              child: Text('-$stepSize'),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              key: const Key('reset'),
              onPressed: _reset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ],
    );
  }
}

// Q: The Tally class has no changing fields, but _TallyState does.
// Why are there two classes?
// A: Tally defines the widget configuration, while _TallyState
// stores mutable data and updates the UI using setState().

// Step 7: Stateful widget with an intentional setState bug.
class BuggyCounter extends StatefulWidget {
  const BuggyCounter({super.key});

  @override
  State<BuggyCounter> createState() => _BuggyCounterState();
}

class _BuggyCounterState extends State<BuggyCounter> {
  int _clicks = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Bug clicks: $_clicks', key: const Key('bug-text')),
        const SizedBox(width: 12),
        ElevatedButton(
          key: const Key('bug-button'),
          onPressed: () {
            // Step 7.2: Fixed by wrapping the update in setState().
            setState(() {
              _clicks += bugStep;
            });
          },
          child: Text('+$bugStep'),
        ),
      ],
    );
  }
}

// Step 7 Q: Before fixing the bug, what happened after three taps?
// A: _clicks was 9 internally, but the screen still displayed 0.
// Reason: setState() was missing, so Flutter did not rebuild the widget.
