import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/Bloc/cubit.dart';
import 'package:to_do_app/Bloc/states.dart';
import 'package:to_do_app/Widgets/customButton.dart';
import 'package:to_do_app/Widgets/customTextField.dart';

// ignore: must_be_immutable
class CreateTaskWidget extends StatelessWidget {
  // ignore: non_constant_identifier_names
  var FormKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  // ignore: non_constant_identifier_names
  String StartTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  // ignore: non_constant_identifier_names
  String EndTime = DateFormat('hh:mm a')
      .format(
        DateTime.now().add(
          const Duration(hours: 1),
        ),
      )
      .toString();
  String selectRemind = '10 min before';
  // ignore: non_constant_identifier_names
  List<dynamic> RemindList = [
    '1  Day Before',
    '1  Hour Before',
    '30 Min Before',
    '10 Min Before',
  ];
  String selectRepeat = 'Weekly';
  // ignore: non_constant_identifier_names
  List<dynamic> RepeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  CreateTaskWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        AppBloc cubit = AppBloc.get(context);
        return Form(
          key: FormKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 15,
                right: 25,
                left: 25,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: cubit.TitleController,
                    hintText: 'Design team meeting',
                    FieldName: 'Title',
                    textInputType: TextInputType.text,
                  ),
                  CustomTextField(
                    controller: cubit.DatelineController,
                    hintText: DateFormat.yMMMd().format(cubit.selectedDateNow),
                    FieldName: 'DeadLine',
                    textInputType: TextInputType.datetime,
                    suffixwidget: IconButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.parse('2100-12-31'),
                        ).then(
                          (dynamic value) {
                            cubit.DatelineController.text =
                                DateFormat.yMMMd().format(value);
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down_sharp,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: cubit.StartTimeController,
                          hintText: StartTime,
                          FieldName: 'Start Time',
                          textInputType: TextInputType.datetime,
                          suffixwidget: IconButton(
                            onPressed: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((dynamic value) {
                                cubit.StartTimeController.text =
                                    value.format(context).toString();
                              });
                            },
                            icon: const Icon(
                              Icons.access_time_outlined,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        flex: 1,
                        child: CustomTextField(
                          controller: cubit.EndTimeController,
                          hintText: EndTime,
                          FieldName: 'End Time',
                          textInputType: TextInputType.datetime,
                          suffixwidget: IconButton(
                            onPressed: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((dynamic value) {
                                cubit.EndTimeController.text =
                                    value.format(context).toString();
                              });
                            },
                            icon: const Icon(
                              Icons.access_time_outlined,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomTextField(
                    controller: cubit.RemindController,
                    hintText: selectRemind,
                    FieldName: ' Remind',
                    textInputType: TextInputType.text,
                    suffixwidget: DropdownButton(
                      items: RemindList.map((value) => DropdownMenuItem(
                          value: value, child: Text(value))).toList(),
                      onChanged: (value) {
                        cubit.RemindController.text = value.toString();
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down_sharp,
                      ),
                    ),
                  ),
                  CustomTextField(
                    controller: cubit.RepeatController,
                    hintText: selectRepeat,
                    FieldName: 'Repeat',
                    textInputType: TextInputType.text,
                    suffixwidget: DropdownButton(
                      items: RepeatList.map((value) => DropdownMenuItem(
                          value: value, child: Text(value))).toList(),
                      onChanged: (value) {
                        cubit.RepeatController.text = value.toString();
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down_sharp,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  CustomButton(
                    text: 'Create Task',
                    onTap: () {
                      if (FormKey.currentState!.validate()) {
                        cubit.InsertDataBase();
                        debugPrint('Data inserted');
                        cubit.notifyHelper.displayNotification(
                          Title: 'ToDo',
                          body: '${cubit.TitleController.text} Created ',
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
