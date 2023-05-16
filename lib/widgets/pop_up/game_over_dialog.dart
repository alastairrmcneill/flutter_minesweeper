import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:minesweeper/services/game_notifier.dart';
import 'package:provider/provider.dart';

class GameOverDialog extends StatelessWidget {
  const GameOverDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameNotifier gameNotifier = Provider.of<GameNotifier>(context, listen: false);
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
          'Game over!',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
        ),
        const SizedBox(height: 75),
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
            'Try again',
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
        const SizedBox(height: 200),
      ],
    );
  }
}

Future showGameOverDialog(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => GameOverDialog(),
  );
}
