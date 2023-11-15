import 'dart:async';

import 'package:flutter/material.dart';
import 'package:time_stream/main.dart';
import 'package:time_stream/time_service.dart';
import 'package:time_stream/timer_controller.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late StreamSubscription _sub;
  int valueFromStream = 0;

  @override
  void initState() {
    super.initState();
    // _sub = controller.stream.listen((event) {
    //   print('page 2 event from stream ${event}');
    //   // if (event == 50) {}
    //   setState(() {
    //     valueFromStream = event;
    //   });
    // });

    _sub  = TimerController.getInstance().timerStream.listen((seconds) {
      print('Timer: $seconds seconds');
        if(mounted){
          setState(() {
            valueFromStream = seconds;
          });
        }
    });
  }
  @override
  void dispose() {
    _sub.cancel();
    // TimerController.getInstance().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          onDoubleTap: (){

          },
          child: Text(
            valueFromStream.toString(),
          ),
        ),
      ),
    );
  }
}
