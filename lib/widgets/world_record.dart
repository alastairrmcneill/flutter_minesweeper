import 'package:flutter/material.dart';
import 'package:minesweeper/services/game_notifier.dart';
import 'package:provider/provider.dart';

class WorldRecordText extends StatelessWidget {
  const WorldRecordText({super.key});

  @override
  Widget build(BuildContext context) {
    GameNotifier gameNotifier = Provider.of<GameNotifier>(context);

    String formatTime(int seconds) {
      int hours = seconds ~/ 3600;
      int minutes = (seconds ~/ 60) % 60;
      int remainingSeconds = seconds % 60;

      String hoursStr = hours > 0 ? hours.toString().padLeft(2, '0') + ':' : '';
      String minutesStr = minutes.toString().padLeft(2, '0');
      String secondsStr = remainingSeconds.toString().padLeft(2, '0');

      return '$hoursStr$minutesStr:$secondsStr';
    }

    Map? data = gameNotifier.records['${gameNotifier.difficulty}'] as Map?;

    if (data == null) {
      return const Text('');
    } else {
      String name = data['name'] as String;
      int seconds = data['seconds'] as int;

      return Text(
        'World record: ${formatTime(seconds)} by $name',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      );
    }
  }
}
