// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/Bloc/cubit.dart';
import 'package:to_do_app/Bloc/states.dart';
import 'package:to_do_app/Screens/emptyScreen.dart';
import 'package:to_do_app/Shared/Component/taskTile.dart';

class ShowTask extends StatelessWidget {
  const ShowTask({
    Key? key,
    index,
  }) : super(
          key: key,
        );

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
        AppBloc cubit = AppBloc.get(
          context,
        );
        return AppBloc.get(
          context,
        ).allTasks.isEmpty
            ? const Expanded(
                child: EmptyScreen(),
              )
            : Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    AppBloc.get(
                      context,
                    ).GetDataFromDataBase();
                  },
                  child: ListView.builder(
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      // ignore: non_constant_identifier_names
                      var Tasks = cubit.allTasks;
                      if (Tasks[index]['repeat'] == 'Daily') {
                        DateTime date = DateFormat.jm().parse(
                          Tasks[index]['starttime'].toString(),
                        );
                        var myTime = DateFormat(
                          'HH:mm',
                        ).format(
                          date,
                        );
                        cubit.notifyHelper.scheduledNotification(
                            int.parse(
                              myTime.toString().split(':')[0],
                            ),
                            int.parse(
                              myTime.toString().split(':')[1],
                            ),
                            Tasks);

                        return TaskTile(
                          item: AppBloc.get(
                            context,
                          ).allTasks[index],
                          color:
                              cubit.colorslist[index % cubit.colorslist.length],
                        );
                      }
                      if (Tasks[index]['dateline'] ==
                          (cubit.scheduleDate != null
                              ? DateFormat.yMMMd().format(
                                  cubit.scheduleDate!,
                                )
                              : DateFormat.yMMMd().format(
                                  cubit.selectedDateNow,
                                ))) {
                        return TaskTile(
                          item: AppBloc.get(
                            context,
                          ).allTasks[index],
                          color:
                              cubit.colorslist[index % cubit.colorslist.length],
                        );
                      } else {
                        return Container();
                      }
                    },
                    itemCount: AppBloc.get(
                      context,
                    ).allTasks.length,
                  ),
                ),
              );
      },
    );
  }
}
