import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String message;

  const ErrorScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(Icons.error_sharp, color: Theme.of(context).colorScheme.error),
          Text(
            'Algo deu errado...',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall!.apply(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
        ],
      ),
    );
  }
}