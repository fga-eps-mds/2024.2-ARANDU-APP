import 'package:flutter/material.dart';

class TextAndLink extends StatelessWidget {
  final String text;
  final String link;
  final Widget page;

  const TextAndLink({
    super.key,
    required this.text,
    required this.link,
    required this.page,
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
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => page,
                ),
              );
            },
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

