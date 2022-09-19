import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Bloc/cubit.dart';
import 'package:to_do_app/Bloc/observerBloc.dart';
import 'package:to_do_app/Screens/boardScreen.dart';
import 'package:to_do_app/Shared/Style/theme.dart';
import 'package:to_do_app/Utils/notficationServices.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotifyHelper().initializeNotification();
  NotifyHelper().requestIOSPermissions();

  // ignore: deprecated_member_use
  BlocOverrides.runZoned(
    () {
      runApp(
        const MyApp(),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(
          key: key,
        );
  @override
  Widget build(
    BuildContext context,
  ) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (
            BuildContext context,
          ) =>
              AppBloc()
                ..Notification()
                ..CreateDataBase(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDo App',
        theme: lightthemes,
        home: Boardscreen(),
      ),
    );
  }
}
