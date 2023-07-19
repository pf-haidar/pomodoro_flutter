import 'package:flutter/material.dart';

class TimerButtonWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onPressed;

  const TimerButtonWidget({
    super.key,
    required this.text,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        textStyle: const TextStyle(
          fontSize: 25,
        ),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              icon,
              size: 30,
            ),
          ),
          Text(text),
        ],
      ),
    );
  }
}
