import 'package:flutter/material.dart';
import 'package:to_do_app/Constant/constant.dart';
import 'package:to_do_app/Shared/Component/createTaskWidget.dart';
import 'package:to_do_app/Widgets/customIconButton.dart';

// ignore: must_be_immutable
class CreateTaskScreen extends StatelessWidget {
  // ignore: non_constant_identifier_names
  var ScaffoldKey = GlobalKey<ScaffoldState>();

  CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ScaffoldKey,
      appBar: AppBar(
          title: const Text('Add Task'),
          leading: CustomIconButton(
            onTap: () {
              NavigatePop(context: context);
            },
            Widgeticon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
          )),
      body: CreateTaskWidget(),
    );
  }
}
