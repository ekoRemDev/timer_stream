import 'dart:async';

StreamController<int> controller = StreamController<int>.broadcast();

class TimeService {
  static final TimeService _timerServiceInstance = TimeService._internal();

  // final Timer _timer = Timer(const Duration(seconds: 10), () {
  //   print('aaa');
  // });

  final Timer _timerTicker = Timer.periodic(const Duration(seconds: 10), (_) {
    print('bbb');
  });

  TimeService._internal();

  static TimeService getInstance() {
    return _timerServiceInstance;
  }

  // static Timer getTimer() {
  //   return TimeService._internal()._timer;
  // }

  static Timer getTimerPeriodic() {
    return TimeService._internal()._timerTicker;
  }

  void start() {
    // Timer.periodic(Duration(seconds: 1), tick);
    // getTimer().tick;
    getTimerPeriodic().tick;
    // timer.tick;
    // tick(timer);
  }

  void pause() {
    getTimerPeriodic().cancel();
  }

  void resume() {
    Timer.periodic(Duration(seconds: 1), tick);
  }

  void tick(Timer timer) {
    print('time is ticking with sigelton ${timer.tick}');
    controller.add(timer.tick);

    if (timer.tick >= 20) {
      timer.cancel();
      // pause();
    }
  }

  void dispose() {
    // timer.cancel();
    getTimerPeriodic().cancel();
  }
}
