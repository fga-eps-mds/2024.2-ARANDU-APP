import 'package:flutter/material.dart';
import 'package:aranduapp/core/log/log.dart';

class ErrorPopUp extends StatelessWidget {
  final Widget content;

  const ErrorPopUp({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Align(
        alignment: Alignment.centerLeft,
        child: Icon(
          Icons.error,
          size: 40,
          color: Theme.of(context).colorScheme.error,
        ),
      ),
      content: content,
      actions: <Widget>[
        TextButton(
          onPressed: () => {Log.d('tap'), Navigator.pop(context, 'OK')},
          child: const Text('OK'),
        ),
      ],
    );
  }
}
