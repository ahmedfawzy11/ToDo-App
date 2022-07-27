import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Shared/Components/components.dart';
import 'package:to_do_app/Shared/Cubit/cubit.dart';
import 'package:to_do_app/Shared/Cubit/states.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).doneTasks;
        return tasksBuilder(
          tasks: tasks,
        );
      },
    );
  }
}
