import 'package:flutter/material.dart';
import 'package:to_do_app/Shared/Style/colors.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onTap;
  // ignore: non_constant_identifier_names
  final Widget Widgeticon;
  final Color color;
  final double iconSize;

  // ignore: non_constant_identifier_names
  const CustomIconButton(
      {Key? key,
      required this.onTap,
      // ignore: non_constant_identifier_names
      required this.Widgeticon,
      this.color = defultColor,
      this.iconSize = 25})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        color: color, iconSize: iconSize, onPressed: onTap, icon: Widgeticon);
  }
}
