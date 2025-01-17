import 'package:aranduapp/core/state/command.dart';
import 'package:flutter/material.dart';

class CommandButton extends StatelessWidget {
  final Command command;
  final String nameButton;

  final VoidCallback onSuccessCallback;
  final VoidCallback tap;
  final ValueChanged<String> onErrorCallback;

  const CommandButton({
    super.key,
    required this.command,
    required this.tap,
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
            key: const Key('elevated_button_key'),
            onPressed: () async {
              tap();
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
