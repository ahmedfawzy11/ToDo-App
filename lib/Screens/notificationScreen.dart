// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:to_do_app/Constant/constant.dart';
import 'package:to_do_app/Widgets/customIconButton.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({
    Key? key,
    required this.payload,
  }) : super(
          key: key,
        );
  final String payload;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Add Task',
          ),
          leading: CustomIconButton(
            onTap: () {
              NavigatePop(
                context: context,
              );
            },
            Widgeticon: const Icon(
              Icons.arrow_back_ios,
            ),
            color: Colors.black,
          )),
      body: Center(
        child: Text(
          payload.toString().split(
                '|',
              )[0],
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
