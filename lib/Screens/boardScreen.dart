import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Bloc/cubit.dart';
import 'package:to_do_app/Bloc/states.dart';
import 'package:to_do_app/Constant/constant.dart';
import 'package:to_do_app/Screens/scheduleScreen.dart';
import 'package:to_do_app/Shared/Component/boardWidget.dart';
import 'package:to_do_app/Widgets/customIconButton.dart';

// ignore: must_be_immutable
class Boardscreen extends StatelessWidget {
  // ignore: non_constant_identifier_names
  var ScaffoldKey = GlobalKey<ScaffoldState>();

  Boardscreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (
        BuildContext context,
        AppStates state,
      ) {},
      builder: (
        BuildContext context,
        AppStates state,
      ) {
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            key: ScaffoldKey,
            appBar: AppBar(
              title: const Text(
                'Board',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              actions: [
                CustomIconButton(
                  onTap: () {
                    NavigateTo(
                      context: context,
                      router: const ScheduleScreen(),
                    );
                  },
                  Widgeticon: const Icon(
                    Icons.date_range,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            body: const BoarderWidget(),
          ),
        );
      },
    );
  }
}
