import 'package:aranduapp/core/state/command.dart';
import 'package:flutter/material.dart';

class Requestbutton extends StatelessWidget {
  final Command0 command;
  final String nameButton;

  final VoidCallback onSuccessCallback;
  final ValueChanged<String> onErrorCallback;

  const Requestbutton({
    super.key,
    required this.command,
    required this.nameButton,
    required this.onSuccessCallback,
    required this.onErrorCallback,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: command,
      builder: (context, child) {
        if (command.isError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onErrorCallback(command.result!.asError!.error.toString());
          });
        }

        if (command.isOk) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onSuccessCallback();
          });
        }

        return SizedBox(
          width: 291,
          height: 64,
          child: ElevatedButton(
            onPressed: () async {
              command.execute();
            },
            child: command.running
                ? const CircularProgressIndicator(value: null)
                : Text(nameButton),
          ),
        );
      },
    );
  }
}
