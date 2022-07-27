import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/Bloc/states.dart';
import 'package:to_do_app/Utils/notfication_services.dart';

class AppBloc extends Cubit<AppStates> {
  AppBloc() : super(InitialAppState());

  static AppBloc get(context) => BlocProvider.of(context);

  late Database db;

  // ignore: non_constant_identifier_names
  TextEditingController TitleController = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController DatelineController = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController StartTimeController = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController EndTimeController = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController RemindController = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController RepeatController = TextEditingController();
  DateTime selectedDateNow = DateTime.now();

  List<Map> allTasks = [];
  // ignore: non_constant_identifier_names
  List<Map> CompletedTasks = [];
  // ignore: non_constant_identifier_names
  List<Map> UnCompletedTasks = [];
  // ignore: non_constant_identifier_names
  List<Map> FavoriteTask = [];

  List<Color> colorslist = [
    Colors.blue.shade400,
    Colors.pink.shade400,
    Colors.orange.shade400,
    Colors.yellow.shade600
  ];

  // ignore: non_constant_identifier_names
  void CreateDataBase() async {
    await openDatabase(
      'Todo.db',
      version: 1,
      onCreate: (database, version) async {
        debugPrint('DataBase is Created');
        await database
            .execute(
                'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, dateline TEXT, starttime TEXT, endtime TEXT,remind TEXT,repeat TEXT ,completed INTEGER , is_fav TEXT,status TEXT)')
            .then(
          (value) {
            debugPrint('Table created');
            emit(AppDataBaseTableCreatedState());
          },
        ).catchError(
          (error) {
            debugPrint('Error when Create Table ${error.toString()}');
          },
        );
      },
      onOpen: (database) {
        db = database;
        GetDataFromDataBase();
        debugPrint('open DataBase');
      },
    ).then(
      (value) {
        db = value;
        emit(AppCreateDataBaseState());
      },
    );
  }

  // ignore: non_constant_identifier_names
  void InsertDataBase({bool isFav = false}) async {
    await db.transaction(
      (txn) async {
        txn
            .rawInsert(
                'INSERT INTO Tasks(title, dateline,start time,end time,remind,repeat,is completed,status, is_fav) VALUES("${TitleController.text}"," ${DatelineController.text}", "${StartTimeController.text}","${EndTimeController.text}","${RemindController.text}","${RepeatController.text}","0","unCompleted" ,"$isFav")')
            .then(
          (value) {
            debugPrint('$value insert successfully');
            TitleController.clear();
            DatelineController.clear();
            StartTimeController.clear();
            EndTimeController.clear();
            RemindController.clear();
            RepeatController.clear();
            GetDataFromDataBase();
            emit(AppInsertDataBaseState());
          },
        ).catchError(
          (error) {
            debugPrint('Error when insert new  ${error.toString()}');
          },
        );
      },
    );
  }

  // ignore: non_constant_identifier_names
  void GetDataFromDataBase() async {
    allTasks = [];
    CompletedTasks = [];
    UnCompletedTasks = [];
    FavoriteTask = [];
    emit(AppGetDataBaseLoadingState());
    db.rawQuery('SELECT * FROM Tasks').then(
      (value) {
        allTasks = value;
        for (var element in value) {
          if (element['status'] == 'completed') {
            CompletedTasks.add(element);
          } else if (element['status'] == 'unCompleted') {
            UnCompletedTasks.add(element);
          }
          if (element['is_fav'] == 'true') {
            FavoriteTask.add(element);
          }
        }
        debugPrint(allTasks.toString());
        emit(AppGetDataBaseState());
      },
    );
  }

  // ignore: non_constant_identifier_names
  void DeleteItem({required int id}) async {
    db.rawDelete('DELETE FROM Tasks WHERE id = ?', ['$id']).then(
      (value) {
        GetDataFromDataBase();
        debugPrint('Success Item Deleted');
        emit(AppDeleteItemState());
      },
    );
  }

  // ignore: non_constant_identifier_names
  void MoveDataBaseScreen({required String status, required int id}) async {
    emit(AppMoveDataBaseScreenState());
    db.rawUpdate(
        'UPDATE Tasks SET status = ?   WHERE id = ?', [status, '$id']).then(
      (value) {
        GetDataFromDataBase();
        emit(AppMoveDataBaseScreenState());
      },
    );
  }

  // ignore: non_constant_identifier_names
  void MarkIsCompleted({
    required int id,
    required int iscompleted,
  }) {
    emit(AppMarkIsCompletedState());
    db.rawUpdate('UPDATE Tasks SET is completed = ?  WHERE id = ?',
        ['$iscompleted', '$id']).then(
      (value) {
        GetDataFromDataBase();
        emit(AppMarkIsCompletedState());
      },
    );
  }

  late NotifyHelper notifyHelper;

  // ignore: non_constant_identifier_names
  void Notification() {
    notifyHelper = NotifyHelper();
    notifyHelper.requestIOSPermissions();
    notifyHelper.initializeNotification();
    emit(NotificationAppState());
  }

  void setIsChecked({required bool value}) {
    value = !value;
    emit(AppSetCheckedSuccess(value));
  }

  void setIsFav(Map<dynamic, dynamic> model) {
    emit(AppSetFavLoadingState());
    db
        .rawUpdate(
            'UPDATE tasks SET is_fav = "${model['is_fav'] == 'true' ? 'false' : 'true'}" WHERE id = "${model['id']}"')
        .then((value) {
      if (kDebugMode) {
        print('${model['title']} is updated successfully');
      }
      emit(AppSetFavSuccessfulState());
      GetDataFromDataBase();
    }).catchError(
      (error) {
        if (kDebugMode) {
          print('Error when update ${model['title']} ${error.toString()}');
        }
        emit(AppSetFavErrorState(error));
      },
    );
  }

  DateTime? scheduleDate;

  void setScheduleDate(DateTime date) {
    scheduleDate = date;
    emit(SelectedDateLineValueState());
  }
}
