import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minesweeper/screens/screens.dart';
import 'package:minesweeper/services/game_notifier.dart';
import 'package:minesweeper/support/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GameNotifier>(
          create: (_) => GameNotifier(),
        ),
      ],
      child: MaterialApp(
        title: 'Minesweeper',
        debugShowCheckedModeBanner: false,
        theme: MyTheme.lightTheme,
        home: const MainMenu(),
      ),
    );
  }
}
