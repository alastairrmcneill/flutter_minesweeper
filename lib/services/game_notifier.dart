// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minesweeper/widgets/widgets.dart';

class GameNotifier extends ChangeNotifier {
  int _difficulty = 1;
  int _boardHeight = 10;
  int _boardWidth = 10;
  int _numberOfBombs = 5;
  int _flaggedTiles = 0;
  int _shownTiles = 0;
  Timer? _timer;
  int _seconds = 0;
  GameState _gameState = GameState.notStarted;
  List<List<GameTile>> _gameBoard = [];
  Map<String, Object> _records = {};

  int get difficulty => _difficulty;
  int get boardHeight => _boardHeight;
  int get boardWidth => _boardWidth;
  int get flaggedTiles => _flaggedTiles;
  int get numberOfBombs => _numberOfBombs;
  String get time => formatTime();
  int get timeInSeconds => _seconds;
  GameState get gameState => _gameState;
  List<List<GameTile>> get gameBoard => _gameBoard;
  Map<String, Object> get records => _records;

  set setRecords(Map<String, Object> records) {
    _records = records;
    notifyListeners();
  }

  set setDifficulty(int difficulty) {
    _difficulty = difficulty;
    notifyListeners();
  }

  void startGame({required int difficulty}) {
    _difficulty = difficulty;
    if (_difficulty == 1) {
      _numberOfBombs = 10;
      _boardWidth = 7;
      _boardHeight = 11;
    } else if (_difficulty == 2) {
      _numberOfBombs = 30;
      _boardWidth = 11;
      _boardHeight = 17;
    } else if (_difficulty == 3) {
      _numberOfBombs = 75;
      _boardWidth = 15;
      _boardHeight = 23;
    }
    _gameState = GameState.playing;
    _shownTiles = 0;
    _seconds = 0;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());

    generateGameBoard();
    notifyListeners();
  }

  void cancelGame() {
    _gameState = GameState.notStarted;
    _flaggedTiles = 0;
    _timer?.cancel();
    _gameBoard = List.generate(_boardHeight, (i) {
      return List.generate(_boardWidth, (j) {
        return GameTile(row: i, col: j);
      });
    });
    _shownTiles = 0;
  }

  void generateGameBoard() {
    // Generate empty board
    _gameBoard = List.generate(_boardHeight, (i) {
      return List.generate(_boardWidth, (j) {
        return GameTile(row: i, col: j);
      });
    });

    // Cancel all flags
    _flaggedTiles = 0;
    // Add bombs

    Random random = Random();
    List<int> bombLocations = [];

    while (bombLocations.length < _numberOfBombs) {
      int randomNumber = random.nextInt(_boardHeight * _boardWidth);

      if (!bombLocations.contains(randomNumber)) {
        bombLocations.add(randomNumber);
      }
    }

    for (var location in bombLocations) {
      int row = location ~/ _boardWidth;
      int col = location % _boardWidth;

      // Set as bomb
      _gameBoard[row][col].bomb = true;
      // _gameBoard[row][col].shown = true;

      // Check surrounding cells and increment number of bombs
      for (var i = -1; i < 2; i++) {
        for (var j = -1; j < 2; j++) {
          if (!(i == 0 && j == 0)) {
            if (row + i >= 0 && row + i < _boardHeight && col + j >= 0 && col + j < _boardWidth) {
              gameBoard[row + i][col + j].surroundingBombs++;
            }
          }
        }
      }
    }
  }

  void play(BuildContext context, {required int row, required int col}) {
    if (gameBoard[row][col].shown || gameBoard[row][col].flagged) return;

    gameBoard[row][col].shown = true;

    if (gameBoard[row][col].bomb) {
      lostGame(context);
      notifyListeners();
      return;
    }

    _shownTiles++;

    if (_shownTiles == _boardWidth * _boardHeight - _numberOfBombs) {
      wonGame(context);
      notifyListeners();
      return;
    }

    if (gameBoard[row][col].surroundingBombs == 0) {
      for (var i = -1; i < 2; i++) {
        for (var j = -1; j < 2; j++) {
          if (!(i == 0 && j == 0)) {
            if (row + i >= 0 && row + i < _boardHeight && col + j >= 0 && col + j < _boardWidth) {
              play(context, row: row + i, col: col + j);
            }
          }
        }
      }
    }

    notifyListeners();
  }

  void lostGame(BuildContext context) {
    _gameState = GameState.lost;
    _timer?.cancel();
    showBombs();
    showGameOverDialog(context);
  }

  void wonGame(BuildContext context) {
    _timer?.cancel();
    _gameState = GameState.won;
    showFlags();
    showWonGameDialog(context);
  }

  void flag(BuildContext context, {required int row, required int col}) {
    if (_gameBoard[row][col].flagged) {
      // If true then set to false
      _gameBoard[row][col].flagged = false;
      _flaggedTiles--;
    } else {
      // If false then set to true but only if there is enough space left
      if (_flaggedTiles != numberOfBombs) {
        _gameBoard[row][col].flagged = true;
        _flaggedTiles++;
      }
    }
    notifyListeners();
  }

  void addTime() {
    _seconds++;
    notifyListeners();
  }

  void showFlags() {
    for (var row in _gameBoard) {
      for (var tile in row) {
        if (tile.bomb) {
          tile.flagged = true;
        }
      }
    }
    notifyListeners();
  }

  void showBombs() {
    for (var row in _gameBoard) {
      for (var tile in row) {
        if (tile.bomb) {
          tile.shown = true;
        }
      }
    }
    notifyListeners();
  }

  String formatTime() {
    int hours = _seconds ~/ 3600;
    int minutes = (_seconds ~/ 60) % 60;
    int remainingSeconds = _seconds % 60;

    String hoursStr = hours > 0 ? hours.toString().padLeft(2, '0') + ':' : '';
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$hoursStr$minutesStr:$secondsStr';
  }
}

enum GameState {
  notStarted,
  playing,
  lost,
  won;
}
