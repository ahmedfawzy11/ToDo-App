import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:to_do_app/Shared/Style/colors.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Empty ..',
            style: TextStyle(
              color: defultColor,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              BounceInDown(
                duration: const Duration(seconds: 3),
                child: Square(),
              ),
              BounceInUp(
                duration: const Duration(seconds: 3),
                child: Square(),
              ),
              BounceInLeft(
                duration: const Duration(seconds: 3),
                child: Square(),
              ),
              BounceInRight(
                duration: const Duration(seconds: 3),
                child: Square(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget Square() => Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        color: defultColor,
      ),
    );
