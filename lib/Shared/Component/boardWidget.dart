import 'package:flutter/material.dart';
import 'package:to_do_app/Constant/constant.dart';
import 'package:to_do_app/Screens/completedScreen.dart';
import 'package:to_do_app/Screens/createTaskScreen.dart';
import 'package:to_do_app/Screens/unCompletedScreen.dart';
import 'package:to_do_app/Shared/Component/allScreen.dart';
import 'package:to_do_app/Shared/Component/favoriteWidget.dart';
import 'package:to_do_app/Widgets/customButton.dart';

class BoarderWidget extends StatelessWidget {
  const BoarderWidget({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
          ),
          child: const TabBar(
            tabs: [
              Tab(
                text: 'All',
              ),
              Tab(
                text: 'Completed',
              ),
              Tab(
                text: 'UnCompleted',
              ),
              Tab(
                text: 'Favorite',
              ),
            ],
          ),
        ),
        //Screens
        const Expanded(
          child: TabBarView(
            children: [
              AllScreen(),
              CompletedScreen(),
              UnCompletedScreen(),
              FavoriteScreen(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 15,
            right: 25,
            left: 25,
          ),
          child: CustomButton(
            text: 'Create Task',
            onTap: () {
              NavigateTo(
                context: context,
                router: CreateTaskScreen(),
              );
            },
          ),
        ),
      ],
    );
  }
}
