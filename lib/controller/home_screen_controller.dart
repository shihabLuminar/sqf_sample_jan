import 'dart:developer';

import 'package:sqf_sample_jan/model/student_model.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreenController {
  static late Database database;
  static List<Map<String, Object?>> data = [];
  static List<StudentModel> studentsList = [];
  // to initialise database
  static Future<void> initDb() async {
    // open the database
    database = await openDatabase("sample.db", version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Student (id INTEGER PRIMARY KEY, name TEXT, phoneNumber INTEGER)');
    });
  }

// function to add a new data into db
  static Future addData() async {
    await database.rawInsert(
        'INSERT INTO Student(name, phoneNumber) VALUES(?, ?)',
        ['sdfghj', 345678]);
  }

  //get all data from databse
  static Future getAllData() async {
    data = await database.rawQuery('SELECT * FROM Student');
    studentsList = data
        .map((e) => StudentModel(
            id: int.parse(e["id"].toString()),
            name: e["name"].toString(),
            ph: int.parse(e["phoneNumber"].toString())))
        .toList();
    log(data.toString());
  }

  static Future deleteData(var id) async {
    await database.rawDelete('DELETE FROM Student WHERE id = ?', [id]);
    await getAllData();
  }

  static Future editData(var id) async {
    // Update some record
    await database.rawUpdate(
        'UPDATE Student SET name = ?, phoneNumber = ? WHERE id = ?',
        ['editted', '9876', id]);
    await getAllData();
  }
}
