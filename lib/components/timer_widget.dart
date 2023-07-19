import 'package:flutter/material.dart';
import 'package:pomodoro_flutter/components/timer_button_widget.dart';
import 'package:pomodoro_flutter/store/pomodoro.store.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);

    return Observer(
      builder: (_) {
        return Container(
          color: store.isWorking() ? Colors.red : Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                store.isWorking() ? 'Hora de Trabalhar' : 'Hora de Descansar',
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '${store.minutes.toString().padLeft(2, '0')}:${store.seconds.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  fontSize: 120,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!store.started)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TimerButtonWidget(
                        text: 'Iniciar',
                        icon: Icons.play_arrow,
                        onPressed: store.startTimer,
                      ),
                    ),
                  if (store.started)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TimerButtonWidget(
                        text: 'Parar',
                        icon: Icons.stop,
                        onPressed: store.stopTimer,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TimerButtonWidget(
                      text: 'Reiniciar',
                      icon: Icons.refresh,
                      onPressed: store.resetTimer,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
