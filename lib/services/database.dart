import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper/services/game_notifier.dart';
import 'package:minesweeper/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RecordsDatabase {
  static final _db = FirebaseFirestore.instance;
  static final CollectionReference _minesweeperRef = _db.collection('minesweeper');

  // Read records
  static Future read(BuildContext context) async {
    GameNotifier gameNotifier = Provider.of<GameNotifier>(context, listen: false);
    QuerySnapshot snapshot = await _minesweeperRef.get();
    Map<String, Object> records = {};
    for (var doc in snapshot.docs) {
      records[doc.id] = doc.data() ?? {};
    }

    gameNotifier.setRecords = records;
  }

  static Future<bool> writeRecord(BuildContext context, String name) async {
    GameNotifier gameNotifier = Provider.of<GameNotifier>(context, listen: false);

    DocumentReference _ref = _minesweeperRef.doc('${gameNotifier.difficulty}');
    bool result = false;

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi &&
        connectivityResult != ConnectivityResult.ethernet &&
        connectivityResult != ConnectivityResult.vpn) {
      showOfflineDialog(context);
    } else {
      await _ref.set({
        'name': name,
        'seconds': gameNotifier.timeInSeconds,
      }).whenComplete(
        () => result = true,
      );
      read(context);
    }

    return result;
  }
}
