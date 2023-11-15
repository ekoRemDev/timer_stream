import 'dart:async';

class TimerService {
  bool _isRunning = false;
  bool _isPaused = false;
  late int _remainingSeconds;
  late Timer _timer;
  Function(bool)? onTimerComplete;

  TimerService({required this.onTimerComplete});
  TimerService.just();

  bool get isRunning => _isRunning;
  bool get isPaused => _isPaused;
  int get remainingSeconds => _remainingSeconds;

  void start(int seconds) {
    if (!_isRunning) {
      _remainingSeconds = seconds;
      _isRunning = true;
      _isPaused = false;
      _timer = Timer.periodic(Duration(seconds: 1), _tick);
    }
  }

  void pause() {
    if (_isRunning && !_isPaused) {
      _timer.cancel();
      _isPaused = true;
    }
  }

  void resume() {
    if (_isRunning && _isPaused) {
      _timer = Timer.periodic(Duration(seconds: 1), _tick);
      _isPaused = false;
    }
  }

  void _tick(Timer timer) {
    _remainingSeconds++;
    if (_remainingSeconds >= 30) {
      _isRunning = false;
      _timer.cancel();
      if (onTimerComplete != null) {
        onTimerComplete!(true);
      }
    }
  }

  void dispose() {
    if (_isRunning) {
      _timer.cancel();
    }
  }
}