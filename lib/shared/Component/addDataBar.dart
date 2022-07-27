import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Bloc/cubit.dart';
import 'package:to_do_app/Shared/Style/colors.dart';

class AddDataBar extends StatelessWidget {
  const AddDataBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, right: 25, left: 25, bottom: 25),
      child: DatePicker(
        DateTime.now(),
        height: 90,
        width: 47,
        initialSelectedDate: DateTime.now(),
        selectionColor: defultColor,
        selectedTextColor: Colors.white,
        onDateChange: (newdate) {
          AppBloc.get(context).setScheduleDate(newdate);
          if (kDebugMode) {
            print(AppBloc.get(context).scheduleDate);
          }
        },
      ),
    );
  }
}
