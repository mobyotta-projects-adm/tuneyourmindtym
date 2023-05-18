import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tuneyourmindtym/TYMNotificationsHelper.dart';

class TYMAlarmsDb {
  static final TYMAlarmsDb instance  = TYMAlarmsDb._init();

  TYMAlarmsDb._init();

  static Database? _database;
  Future<Database> get database async => _database ??=await _initDatabse();

  Future<Database> _initDatabse() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'tymalarms.db');
    return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
    );
  }

  FutureOr _onCreate(Database db, int version) async{
    await db.execute('''
    CREATE TABLE tymalarms(
    id INTEGER PRIMARY KEY,
    notifBody TEXT,
    notifTime TEXT
    )
    ''');
  }

  Future<List<MyAlarms>> getTymAlarms() async{
    Database db = await instance.database;
    var allAlarms = await db.query('tymalarms', orderBy: 'notifTime');
    List<MyAlarms> alarmsList = allAlarms.isNotEmpty
    ? allAlarms.map((e) => MyAlarms.fromMap(e)).toList()
    : [];

    return alarmsList;
  }

  Future<int> addAlarm(MyAlarms myAlarms) async {
    Database db = await instance.database;
    return await db.insert('tymalarms', myAlarms.toMap());
  }

  Future<int> deleteAlarm(int id) async{
    Database db = await instance.database;
    TYMNotificationsHelper.cancel(id);
    return await db.delete('tymalarms', where: 'id = ?', whereArgs: [id]);
  }
}



MyAlarms myAlarmsFromMap(String str) => MyAlarms.fromMap(json.decode(str));

String myAlarmsToMap(MyAlarms data) => json.encode(data.toMap());

class MyAlarms {
  MyAlarms({
    required this.id,
    required this.notifBody,
    required this.notifTime,
  });

  final int id;
  final String notifBody;
  final String notifTime;

  factory MyAlarms.fromMap(Map<String, dynamic> json) => MyAlarms(
    id: json["id"],
    notifBody: json["notifBody"],
    notifTime: json["notifTime"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "notifBody": notifBody,
    "notifTime": notifTime,
  };
}