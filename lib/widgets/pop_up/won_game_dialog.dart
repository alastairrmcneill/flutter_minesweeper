// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:minesweeper/services/game_notifier.dart';
import 'package:minesweeper/widgets/pop_up/save_time_dialog.dart';

class WonGameDialog extends StatelessWidget {
  const WonGameDialog({
    Key? key,
  }) : super(key: key);

  Widget _buildWorldRecord(BuildContext context, GameNotifier gameNotifier) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            'This is a new world record! Type your name and click save to show other people!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                  fontSize: 15,
                ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              String result = await showSaveTimeDialog(context);

              if (result == 'Saved') {
                Navigator.pop(context);
                gameNotifier.startGame(difficulty: gameNotifier.difficulty);
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color?>(Colors.transparent),
              foregroundColor: MaterialStateProperty.all<Color?>(Colors.white),
              elevation: MaterialStateProperty.all<double?>(0),
              minimumSize: MaterialStateProperty.all<Size>(const Size(150, 40)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(
                    width: 2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            child: const Text(
              'Save',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    GameNotifier gameNotifier = Provider.of<GameNotifier>(context, listen: false);

    bool newRecordTime = false;

    Map? data = gameNotifier.records['${gameNotifier.difficulty}'] as Map?;

    if (data != null) {
      int? recordTime = data['seconds'] as int?;

      if (recordTime != null) {
        if (gameNotifier.timeInSeconds < recordTime) {
          newRecordTime = true;
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 100),
        Icon(
          FontAwesomeIcons.bomb,
          color: Colors.white,
          size: MediaQuery.of(context).size.width * 0.3,
        ),
        const SizedBox(height: 50),
        Text(
          'You won!',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
        ),
        const SizedBox(height: 10),
        Text(
          'In a time of ${gameNotifier.time}',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 20,
              ),
        ),
        newRecordTime ? _buildWorldRecord(context, gameNotifier) : const SizedBox(height: 50),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            gameNotifier.startGame(difficulty: gameNotifier.difficulty);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color?>(Colors.transparent),
            foregroundColor: MaterialStateProperty.all<Color?>(Colors.white),
            elevation: MaterialStateProperty.all<double?>(0),
            minimumSize: MaterialStateProperty.all<Size>(const Size(150, 40)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: const BorderSide(
                  width: 2,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          child: const Text(
            'Try Again',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            gameNotifier.cancelGame();
            Navigator.pop(context);
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color?>(Colors.transparent),
            foregroundColor: MaterialStateProperty.all<Color?>(Colors.white),
            elevation: MaterialStateProperty.all<double?>(0),
            minimumSize: MaterialStateProperty.all<Size>(const Size(150, 40)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: const BorderSide(
                  width: 2,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          child: const Text(
            'Exit',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
      ],
    );
  }
}

Future showWonGameDialog(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => WonGameDialog(),
  );
}
