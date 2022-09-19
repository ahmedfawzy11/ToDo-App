// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:to_do_app/shared/Style/colors.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color textcolor;

  const CustomTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.textcolor = defaultColor,
  }) : super(
          key: key,
        );

  @override
  Widget build(
    BuildContext context,
  ) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textcolor,
        ),
      ),
    );
  }
}
