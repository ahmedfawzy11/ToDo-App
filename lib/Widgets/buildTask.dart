import 'package:flutter/material.dart';
import 'package:to_do_app/Bloc/cubit.dart';
import 'package:to_do_app/Widgets/customIconButton.dart';

class BuildTask extends StatelessWidget {
  final Map item;
  final Color color;
  const BuildTask({
    Key? key,
    required this.item,
    required this.color,
  }) : super(
          key: key,
        );

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        right: 25,
        left: 25,
      ),
      child: Dismissible(
        key: Key(
          item['id'].toString(),
        ),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: AlignmentDirectional.centerEnd,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              20,
            ),
            color: Colors.red.shade400,
          ),
          child: Padding(
              padding: const EdgeInsets.fromLTRB(
                0.0,
                0.0,
                10.0,
                0.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'Delete item',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 28,
                  ),
                ],
              )),
        ),
        onDismissed: (direction) {
          AppBloc.get(context).DeleteItem(
            id: item['id'],
          );
          AppBloc.get(context).notifyHelper.displayNotification(
                Title: 'ToDo',
                body: '${item['title']} Deleted',
              );
          AppBloc.get(context).notifyHelper.cancelNotification(
                item,
              );
        },
        child: Padding(
          padding: const EdgeInsets.only(
            top: 15,
          ),
          child: Row(
            children: [
              Transform.scale(
                scale: 1.5,
                child: Checkbox(
                  value: item['status'] == 'completed' ? true : false,
                  side: MaterialStateBorderSide.resolveWith(
                    (states) => BorderSide(
                      width: 2.0,
                      color: color,
                    ),
                  ),
                  splashRadius: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      4.0,
                    ),
                  ),
                  onChanged: (value) {
                    if (value! == true) {
                      AppBloc.get(context).MoveDataBaseScreen(
                        status: item['status'] == 'completed'
                            ? 'unCompleted'
                            : 'completed',
                        id: item['id'],
                      );
                    } else {
                      AppBloc.get(context).MoveDataBaseScreen(
                        status: item['status'] == 'unCompleted'
                            ? 'completed'
                            : 'unCompleted',
                        id: item['id'],
                      );
                    }
                  },
                  checkColor: Colors.white,
                  activeColor: color,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '${item['title']}',
              ),
              const Spacer(),
              CustomIconButton(
                onTap: () {
                  AppBloc.get(context).setIsFav(
                    item,
                  );
                },
                Widgeticon: item['is_fav'] == 'true'
                    ? const Icon(Icons.favorite)
                    : const Icon(
                        Icons.favorite_border,
                      ),
                color: item['is_fav'] == 'true' ? Colors.red : Colors.grey,
                iconSize: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
