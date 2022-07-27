import 'package:flutter/material.dart';
import 'package:to_do_app/Constant/constant.dart';
import 'package:to_do_app/Shared/Component/scheduleWidget.dart';
import 'package:to_do_app/Widgets/customIconButton.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
        leading: CustomIconButton(
          onTap: () {
            NavigatePop(context: context);
          },
          Widgeticon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
      ),
      body: const ScheduleWidget(),
    );
  }
}
