// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper/services/database.dart';
import 'package:minesweeper/support/theme.dart';

class OfflineDialog extends StatelessWidget {
  const OfflineDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _showIOSDialog(context) : _showAndroidDialog(context);
  }

  AlertDialog _showAndroidDialog(BuildContext context) {
    return AlertDialog(
      content: Text('Sorry, you are offline so this will not be saved.'),
      actions: [
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(context).pop('Saved');
          },
        ),
      ],
    );
  }

  CupertinoAlertDialog _showIOSDialog(
    BuildContext context,
  ) {
    return CupertinoAlertDialog(
      content: Text('Sorry, you are offline so this will not be saved.'),
      actions: [
        CupertinoDialogAction(
          child: const Text('OK'),
          onPressed: () async {
            Navigator.pop(context);
            Navigator.of(context).pop('Saved');
          },
        ),
      ],
    );
  }
}

Future<String> showOfflineDialog(BuildContext context) async {
  String result = await showDialog(
    context: context,
    builder: (context) => OfflineDialog(),
  );
  return result;
}
