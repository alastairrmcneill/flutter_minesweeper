// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:minesweeper/services/game_notifier.dart';
import 'package:provider/provider.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameNotifier gameNotifier = Provider.of<GameNotifier>(context);
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        physics: const ClampingScrollPhysics(),
        itemCount: gameNotifier.boardHeight * gameNotifier.boardWidth,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: gameNotifier.boardWidth),
        itemBuilder: (context, index) {
          int row = index ~/ gameNotifier.boardWidth;
          int col = index % gameNotifier.boardWidth;
          return gameNotifier.gameBoard[row][col];
        },
      ),
    );
  }
}
