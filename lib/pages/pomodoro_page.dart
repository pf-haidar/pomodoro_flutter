import 'package:flutter/material.dart';
import 'package:pomodoro_flutter/components/time_input_widget.dart';
import 'package:pomodoro_flutter/components/timer_widget.dart';
import 'package:pomodoro_flutter/store/pomodoro.store.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PomodoroPage extends StatelessWidget {
  const PomodoroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            child: TimerWidget(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Observer(
              builder: (_) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TimeInputWidget(
                      title: 'Trabalho',
                      value: store.workTime,
                      increment: store.started && store.isWorking()
                          ? null
                          : store.incrementWorkTime,
                      decrement: store.started && store.isWorking()
                          ? null
                          : store.decrementWorkTime,
                    ),
                    TimeInputWidget(
                      title: 'Descanso',
                      value: store.restTime,
                      increment: store.started && store.isResting()
                          ? null
                          : store.incrementRestTime,
                      decrement: store.started && store.isResting()
                          ? null
                          : store.decrementRestTime,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
