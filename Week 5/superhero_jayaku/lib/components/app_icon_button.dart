import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {

  AppIconButton({
    this.tooltip,
    this.icon,
    this.onPressed,
    this.color,
  });

  final String tooltip;
  final Icon icon;
  final Function onPressed;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 36.0,
      tooltip: tooltip,
      icon: icon,
      onPressed: onPressed,
      color: color,
    );
  }
}