import 'package:flutter/material.dart';

class TextAndLink extends StatelessWidget {
  final String text;
  final String link;
  final VoidCallback
      action; 

  const TextAndLink({
    super.key,
    required this.text,
    required this.link,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          GestureDetector(
            onTap: action,
            child: Text(
              ' $link',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
