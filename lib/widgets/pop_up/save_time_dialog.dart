// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper/services/database.dart';
import 'package:minesweeper/support/theme.dart';

class SaveTimeDialog extends StatelessWidget {
  final BuildContext widgetContext;
  SaveTimeDialog({
    Key? key,
    required this.widgetContext,
  }) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _showIOSDialog(widgetContext, form: _buildForm()) : _showAndroidDialog(widgetContext, form: _buildForm());
  }

  AlertDialog _showAndroidDialog(
    BuildContext context, {
    required Widget form,
  }) {
    return AlertDialog(
      content: form,
      actions: [
        TextButton(
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () => Navigator.of(context).pop('Cancel'),
        ),
        TextButton(
          child: const Text('Save'),
          onPressed: () async {
            bool result = await _submit(context);
            if (result) Navigator.of(context).pop('Saved');
          },
        ),
      ],
    );
  }

  CupertinoAlertDialog _showIOSDialog(
    BuildContext context, {
    required Widget form,
  }) {
    return CupertinoAlertDialog(
      content: form,
      actions: [
        CupertinoDialogAction(
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () => Navigator.of(context).pop('Cancel'),
        ),
        CupertinoDialogAction(
          child: const Text('Save'),
          onPressed: () async {
            bool result = await _submit(context);
            if (result) Navigator.of(context).pop('Saved');
          },
        ),
      ],
    );
  }

  Future<bool> _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return false;
    }
    _formKey.currentState!.save();

    // Save to database
    bool result = await RecordsDatabase.writeRecord(context, _nameController.text.trim());

    return result;
  }

  Widget _buildForm() {
    return Material(
      color: Colors.transparent,
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: _nameController,
          maxLength: 15,
          maxLines: 1,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            hintText: 'Name',
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: accentColor.withOpacity(0.5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: accentColor.withOpacity(0.8),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            errorStyle: const TextStyle(color: Colors.red),
          ),
          style: TextStyle(color: accentColor),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Required';
            }
          },
          onSaved: (value) {
            _nameController.text = value!.trim();
          },
        ),
      ),
    );
  }
}

Future<String> showSaveTimeDialog(BuildContext context) async {
  String result = await showDialog(
    context: context,
    builder: (context) => SaveTimeDialog(
      widgetContext: context,
    ),
  );
  return result;
}
