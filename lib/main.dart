import 'dart:async';

import 'package:flutter/material.dart';
import 'package:time_stream/second_page.dart';
import 'package:time_stream/time_service.dart';
import 'package:time_stream/timer_controller.dart';
import 'package:time_stream/timer_service.dart';


// final Stream timeStream =
//     Stream.periodic(const Duration(seconds: 1), (int count) {
//   if (!controller.isClosed) {
//     controller.add(count);
//   }
//   return count;
// });

// final periodicTimer = Timer.periodic(
//   const Duration(seconds: 1),
//   (timer) {
//     // Update user about remaining time
//     if (!controller.isClosed) {
//       controller.add(timer.tick);
//     }
//   },
// );

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // Stream stream = controller.stream;

  late StreamSubscription _sub;

  void _incrementCounter() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SecondPage(),
      ),
    );
    // _sub.cancel();
  }


  // TimerController timerController = TimerController();



  @override
  void initState() {
    super.initState();

    _sub  = TimerController.getInstance().timerStream.listen((seconds) {
      print('Timer: $seconds seconds');
      setState(() {
        _counter = seconds;
      });
    });
// periodicTimer.tick;


    // controller.stream.listen((value) {
    //   print('Value from controller: $value');
    //   // if (value >= 10) {
    //   //   print('hit the target');
    //   //   controller.close();
    //   // }
    //
    //   setState(() {
    //     _counter = value;
    //   });
    // });

    // _sub = timeStream.listen((event) {
    //   // print('event from stream ${event}');
    //   // if (event == 50) {}
    //   setState(() {
    //     _counter = event;
    //   });
    // });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            GestureDetector(
              onTap: (){
                // TimeService.getInstance().start();


                TimerController.getInstance().startTimer();

                // periodicTimer.tick;
                // TimerService(onTimerComplete: (bool ) {
                //
                // }).start(30);
              },
              onDoubleTap: (){
                // periodicTimer.tick;
                print('Double tapped to pause');
                // TimeService.getInstance().pause();
                TimerController.getInstance().stopTimer();

              },
              child: Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
