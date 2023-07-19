import 'dart:async';
import 'dart:core';

import 'package:mobx/mobx.dart';

part 'pomodoro.store.g.dart';

// ignore: library_private_types_in_public_api
class PomodoroStore = _PomodoroStore with _$PomodoroStore;

enum IntervalType { work, rest }

abstract class _PomodoroStore with Store {
  @observable
  bool started = false;

  @observable
  int minutes = 2;

  @observable
  int seconds = 0;

  @observable
  int workTime = 2;

  @observable
  int restTime = 2;

  @observable
  IntervalType intervalType = IntervalType.work;

  Timer? timer;

  @action
  void startTimer() {
    started = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (minutes == 0 && seconds == 0) {
        _changeIntervalType();
      } else if (seconds == 0) {
        seconds = 59;
        minutes--;
      } else {
        seconds--;
      }
    });
  }

  @action
  void stopTimer() {
    started = false;
    timer?.cancel();
  }

  @action
  void resetTimer() {
    stopTimer();
    minutes = isWorking() ? workTime : restTime;
    seconds = 0;
  }

  @action
  void incrementWorkTime() {
    if (workTime <= 59) {
      workTime++;
      if (isWorking()) {
        resetTimer();
      }
    }
  }

  @action
  void decrementWorkTime() {
    if (workTime > 1) {
      workTime--;
      if (isWorking()) {
        resetTimer();
      }
    }
  }

  @action
  void incrementRestTime() {
    if (restTime <= 59) {
      restTime++;
      if (isResting()) {
        resetTimer();
      }
    }
  }

  @action
  void decrementRestTime() {
    if (restTime > 1) {
      restTime--;
      if (isResting()) {
        resetTimer();
      }
    }
  }

  bool isWorking() {
    return intervalType == IntervalType.work;
  }

  bool isResting() {
    return intervalType == IntervalType.rest;
  }

  void _changeIntervalType() {
    if (isWorking()) {
      intervalType = IntervalType.rest;
      minutes = restTime;
    } else {
      intervalType = IntervalType.work;
      minutes = workTime;
    }
    seconds = 0;
  }
}
