import 'dart:async';

class TimerController {
  static TimerController _instance = TimerController._();
  Timer? _timer;
  int _seconds = 0;
  final StreamController<int> _timerController =
      StreamController<int>.broadcast();

  factory TimerController() {
    if (_instance == null) {
      _instance = TimerController._();
    }
    return _instance;
  }

  TimerController._();

  Stream<int> get timerStream => _timerController.stream;

  static TimerController getInstance() {
    return _instance;
  }

  void startTimer() {
    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
        _seconds++;
        _timerController.add(_seconds);
      });
    }
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void resetTimer() {
    stopTimer();
    _seconds = 0;
    _timerController.add(_seconds);
  }

  void dispose() {
    _timerController.close();
  }
}
