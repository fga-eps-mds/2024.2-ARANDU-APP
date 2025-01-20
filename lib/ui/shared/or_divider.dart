import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget{

  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: <Widget>[
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'ou',
              style: Theme.of(context).textTheme.bodySmall!,
            ),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }
}
