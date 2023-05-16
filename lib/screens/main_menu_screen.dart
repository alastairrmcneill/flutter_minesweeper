import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:minesweeper/screens/screens.dart';
import 'package:minesweeper/services/game_notifier.dart';
import 'package:minesweeper/support/theme.dart';
import 'package:minesweeper/widgets/text_divider.dart';
import 'package:provider/provider.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    GameNotifier gameNotifier = Provider.of<GameNotifier>(context);
    return Scaffold(
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Icon(
                    FontAwesomeIcons.bomb,
                    color: Theme.of(context).textTheme.headlineLarge!.color,
                    size: MediaQuery.of(context).size.width * 0.3,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Minesweeper',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontSize: 50,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Find the mines, but don\'t explode them!',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextDivider(text: 'Play'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    gameNotifier.startGame(difficulty: 1);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const GameScreen()));
                  },
                  child: Text('Easy'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    gameNotifier.startGame(difficulty: 2);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const GameScreen()));
                  },
                  child: Text('Medium'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    gameNotifier.startGame(difficulty: 3);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const GameScreen()));
                  },
                  child: Text('Hard'),
                ),
                const SizedBox(height: 200),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
