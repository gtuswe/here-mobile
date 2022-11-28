import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Widget child;

  const Badge({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        child,
        const Icon(
          Icons.circle,
          size: 8,
          color: Colors.red,
        )
      ],
    );
  }
}
