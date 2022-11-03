import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:io';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function onPressed;

//Construtor
  const AdaptativeButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              onPressed;
            },
            child: Text(label))
        : ElevatedButton(
            onPressed: () {
              onPressed;
            },
            style: TextButton.styleFrom(foregroundColor: Colors.purple),
            child: Text(label),
          );
  }
}
