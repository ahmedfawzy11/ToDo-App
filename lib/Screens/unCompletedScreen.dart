import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Bloc/cubit.dart';
import 'package:to_do_app/Bloc/states.dart';
import 'package:to_do_app/Screens/emptyScreen.dart';
import 'package:to_do_app/Widgets/BuildTask.dart';

class UnCompletedScreen extends StatelessWidget {
  const UnCompletedScreen({
    Key? key,
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
        ).UnCompletedTasks.isEmpty
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
                    ) =>
                        BuildTask(
                      item: AppBloc.get(
                        context,
                      ).UnCompletedTasks[index],
                      color: cubit.colorslist[index % cubit.colorslist.length],
                    ),
                    itemCount: AppBloc.get(context).UnCompletedTasks.length,
                  ),
                ),
              );
      },
    );
  }
}
