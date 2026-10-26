
import 'dart:async';

import 'package:flutter/material.dart';

const String studentName = 'Raja Hasham Ahmed';
const String rollNo = '04072313006';

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10;
final int u = seed % 10;

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

const List<String> names = ['Ali', 'Sara', 'Omar', 'Hina', 'Zain', 'Maya'];

const List<String> mains = [
  'start',
  'center',
  'end',
  'spaceBetween',
  'spaceAround',
  'spaceEvenly',
];

const List<String> crosses = ['start', 'center', 'end'];

const List<String> hues = ['teal', 'indigo', 'orange', 'pink', 'green'];

const Map<String, MaterialColor> swatches = {
  'teal': Colors.teal,
  'indigo': Colors.indigo,
  'orange': Colors.orange,
  'pink': Colors.pink,
  'green': Colors.green,
};

final String course = courses[u];

// Steps 1-2: the clock
final int startSec = 5 * (1 + t % 5);
final int tick = 1 + u % 3;
final int ticks = 4 + u % 4;
final int stopAt = startSec + ticks * tick;

// Steps 4-5: the tiles
final String tileA = names[u % 6];
final String tileB = names[(u + 2) % 6];
final String tileC = names[(u + 4) % 6];
final int tapsToMake = 2 + t % 3;

// Step 6: axes
final String mainName = mains[u % 6];
final String crossName = crosses[t % 3];

// Step 8: Expanded and Flexible
final double fixedW = 70.0 + 10 * u;
final int flexA = 1 + t % 3;
final int flexB = 1 + u % 2;

// Step 9: Container
final double boxMargin = 4.0 + 2 * (t % 5);
final double boxPad = 8.0 + 2 * (u % 5);
final double boxRadius = 4.0 * (1 + (t + u) % 4);
final double boxBorder = 1.0 + t % 3;
final String hue = hues[(t + u) % 5];

// Step 10: Stack
final double dotTop = 4.0 + 4 * (t % 4);
final double dotRight = 4.0 + 4 * (u % 4);
final double dotBottom = 4.0 + 4 * ((t + u) % 4);
final double dotLeft = 4.0 + 4 * ((t + 2 * u) % 4);
// ===========================================================================

// Step 2 writes to this list from initState and dispose.
final List<String> lifecycleLog = <String>[];

void main() => runApp(const LabApp());

// Keep the name LabApp and its const constructor.
class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Team Board',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Board: $course'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
       children: [
  const SettingsCard(),
  const SizedBox(height: 12),

  const Welcome(),
  const SizedBox(height: 12),

  const Clock(),
  const SizedBox(height: 12),

  const InfoPanel(),
//Step## 04:
  const SwapBoard(),
  const SummaryRow(),
],
        ),
      ),
    );
  }
}

//Step## 06::
class InfoPanel extends StatelessWidget {
  const InfoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          key: const Key('info-row'),
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Start: $startSec s', key: const Key('row-a')),
            Text('Tick: $tick s', key: const Key('row-b')),
            Text('Stop: $stopAt s', key: const Key('row-c')),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          key: const Key('info-col'),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $studentName', key: const Key('col-a')),
            Text('Roll no: $rollNo', key: const Key('col-b')),
            Text('Course: $course', key: const Key('col-c')),
          ],
        ),
      ],
    );
  }
}





// Provided: shows your personalized numbers. Do not rename.
class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'YOUR SETTINGS (seed $seed)\n'
      'clock: start $startSec, tick $tick, stop at $stopAt\n'
      'tiles: $tileA, $tileB, $tileC '
      '(taps for the Step 5 experiment: $tapsToMake)\n'
      'row main axis: $mainName | column cross axis: $crossName\n'
      'flex: $flexA and $flexB | '
      'fixed width: ${fixedW.toStringAsFixed(0)}\n'
      'box: margin $boxMargin, padding $boxPad, radius $boxRadius, '
      'border $boxBorder, colour $hue\n'
      'stamp: top $dotTop, right $dotRight, '
      'bottom $dotBottom, left $dotLeft',
      key: const Key('settings'),
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
      ),
    );
  }
}

// Provided for Step 7. It overflows on purpose. Do not rename.


//Step### 07::
class SummaryRow extends StatelessWidget {
  const SummaryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Part A: read the widget tree of the $course '
            'board from top to bottom.',
            key: const Key('sum-a'),
          ),
        ),
        Expanded(
          child: Text(
            'Part B: build each box from small widgets and never extend a '
            'built-in class.',
            key: const Key('sum-b'),
          ),
        ),
        Expanded(
          child: Text(
            'Part C: break the layout on purpose, then fix it with '
            'Expanded or Wrap.',
            key: const Key('sum-c'),
          ),
        ),
      ],
    );
  }
}
//PART### 01::

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}


class _ClockState extends State<Clock> {
  late Timer _timer;
  int _seconds = startSec;
  int _builds = 0;

  @override
  void initState() {
    super.initState();

    lifecycleLog.add('initState');

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds += tick;

        if (_seconds >= stopAt) {
          _seconds = stopAt;
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    lifecycleLog.add('dispose');
    super.dispose();
  }

  //TASK## 03:
@override
Widget build(BuildContext context) {
  _builds++;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Session: $_seconds s',
        key: const Key('clock'),
      ),
      Text(
        'Builds: $_builds',
        key: const Key('builds'),
      ),
      Probe(seconds: _seconds),
    ],
  );
}

}


//TASK ###03:

class Probe extends StatelessWidget {
  final int seconds;

  const Probe({super.key, required this.seconds});

  @override
  Widget build(BuildContext context) {
    final above =
        context.findAncestorWidgetOfExactType<Scaffold>() != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Seen at: $seconds s',
          key: const Key('probe-seen'),
        ),
        Text(
          'Widget #${identityHashCode(this)}',
          key: const Key('probe-widget'),
        ),
        Text(
          'Element #${identityHashCode(context)}',
          key: const Key('probe-element'),
        ),
        Text(
          'Context belongs to: ${context.widget.runtimeType}',
          key: const Key('probe-context'),
        ),
        Text(
          'Scaffold above me: $above',
          key: const Key('probe-above'),
        ),
      ],
    );
  }
}
//PART ## 04::
class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Welcome, $studentName',
        key: const Key('welcome'),
      ),
    );
  }
} 

//PART ## 04:
class Tile extends StatefulWidget {
  final String label;

  const Tile(this.label, {super.key});

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  int taps = 0;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          taps++;
        });
      },
      child: Text('${widget.label}: $taps'),
    );
  }
}
//Sterp## 05::

class SwapBoard extends StatefulWidget {
  const SwapBoard({super.key});

  @override
  State<SwapBoard> createState() => _SwapBoardState();
}

class _SwapBoardState extends State<SwapBoard> {
  late List<Tile> tiles;

  @override
  void initState() {
    super.initState();

    tiles = [
      Tile(tileA, key: ValueKey(tileA)),
      Tile(tileB, key: ValueKey(tileB)),
      Tile(tileC, key: ValueKey(tileC)),
    ];
  }

  void swap() {
    setState(() {
      tiles = tiles.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: tiles),
        ElevatedButton(
          key: const Key('swap'),
          onPressed: swap,
          child: const Text('Swap'),
        ),
      ],
    );
  }
}

//---------------------------------ANSWERS----------------------------//
//---------------------------------ANSWERS----------------------------//
//---------------------------------ANSWERS----------------------------//
//Step-1:
// We start the Timer in initState because it runs only once.If we start it in build, multiple
// Timers may start and the clock will run too fast.

//Step-2:
// Builds increases once per second because each timer tick calls setState once.
// Without cancelling the Timer in dispose we may get
// setState() method  being called after dispose().

//Step-3:

// Widget is cheap and can be replaced during rebuilding. Element stays in the 
//tree and keeps the State. RenderObject handles layout and painting what we see on the screen.


//Step# 04:
// This is called composition. Flutter prefers it because small widgets
// are easier to reuse, understand, and maintain for fruther..

//Step # 05:
// Without keys, Flutter matches each widget by position, so its Element
// and State stay on the left even when the label changes.

//Step## 06::
// In a Column, the main axis is vertical. The cross axis is horizontal,
// so CrossAxisAlignment.center moves children left or right.

//Step## 07::
// Constraints go down and sizes go up. Expanded limits each Text to its
// share of the Row's width, allowing the words to wrap instead of overflow.