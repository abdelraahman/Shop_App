import 'package:sqflite/sqflite.dart';
List<Map> allTasks = [];
List<Map> tasks = [];
List<Map> doneTasks = [];
List<Map> archiveTasks = [];
late Database database;