// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:minesweeper/services/game_notifier.dart';
import 'package:provider/provider.dart';

class GameTile extends StatelessWidget {
  final int row;
  final int col;
  bool bomb = false;
  bool shown = false;
  bool flagged = false;
  int surroundingBombs = 0;

  GameTile({
    Key? key,
    required this.row,
    required this.col,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> textColors = [
      Colors.transparent,
      Colors.blue.withOpacity(0.7),
      Colors.green.withOpacity(0.7),
      Colors.red.withOpacity(0.7),
      Color.fromARGB(255, 135, 2, 158).withOpacity(0.7),
      Color.fromARGB(255, 135, 2, 158).withOpacity(0.7),
      Color.fromARGB(255, 135, 2, 158).withOpacity(0.7),
      Color.fromARGB(255, 135, 2, 158).withOpacity(0.7),
      Color.fromARGB(255, 135, 2, 158).withOpacity(0.7),
    ];
    GameNotifier gameNotifier = Provider.of<GameNotifier>(context);
    return Padding(
      padding: const EdgeInsets.all(1),
      child: InkWell(
        onTap: () {
          gameNotifier.play(context, row: row, col: col);
        },
        onLongPress: () {
          gameNotifier.flag(context, row: row, col: col);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(shown ? 0.4 : 1),
            borderRadius: BorderRadius.circular(5 / gameNotifier.difficulty),
          ),
          child: Center(
            child: shown
                ? bomb
                    ? Icon(
                        FontAwesomeIcons.bomb,
                        size: 30.0 - (8 * (gameNotifier.difficulty - 1)),
                      )
                    : AutoSizeText(
                        '$surroundingBombs',
                        style: TextStyle(
                          color: textColors[surroundingBombs],
                          fontWeight: FontWeight.w400,
                          fontSize: 25.0 - (7 * (gameNotifier.difficulty - 1)),
                        ),
                        maxLines: 1,
                      )
                : flagged
                    ? Icon(
                        Icons.flag_rounded,
                        size: 30.0 - (7 * (gameNotifier.difficulty - 1)),
                        color: Colors.deepOrange,
                      )
                    : null,
          ),
        ),
      ),
    );
  }
}
