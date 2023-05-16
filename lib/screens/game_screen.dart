// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:minesweeper/services/game_notifier.dart';
import 'package:minesweeper/support/theme.dart';
import 'package:minesweeper/widgets/widgets.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameNotifier gameNotifier = Provider.of<GameNotifier>(context);
    return WillPopScope(
      onWillPop: () async {
        gameNotifier.cancelGame();
        return true;
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFDCEFFC),
                Color(0xFFB4DBF6),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  foregroundColor: accentColor,
                  title: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(FontAwesomeIcons.stopwatch),
                            ),
                            SizedBox(
                              width: 75,
                              child: Text(
                                gameNotifier.time,
                                style: TextStyle(fontSize: gameNotifier.time.length < 8 ? 20 : 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(FontAwesomeIcons.bomb),
                            ),
                            Text(
                              '${gameNotifier.numberOfBombs - gameNotifier.flaggedTiles}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                      onPressed: () => gameNotifier.startGame(difficulty: gameNotifier.difficulty),
                      icon: const Icon(
                        Icons.refresh_rounded,
                      ),
                    )
                  ],
                ),
                const GameBoard(),
                const SizedBox(height: 40, child: WorldRecordText()),
                const Text(
                  'Tap to show tile.\nHold to flag tile.',
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 1.4, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
