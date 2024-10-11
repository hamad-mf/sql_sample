import 'package:sqflite/sqflite.dart';

class HomeScreenController {
  static late Database myDatabase;
  static List<Map> employeeList = [];

  static Future initDb() async {
    // open the database
    myDatabase = await openDatabase("employeeData.db", version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Employees (id INTEGER PRIMARY KEY, name TEXT, designation TEXT)');
    });
  }

  static Future addEmployee(String name, String designation) async {
    await myDatabase.rawInsert(
        'INSERT INTO Employees(name, designation) VALUES(?, ?)',
        [name, designation]);
    getAllEmoloyee();
  }

  static Future getAllEmoloyee() async {
    // Get the records
    employeeList = await myDatabase.rawQuery('SELECT * FROM Employees');
    print(employeeList);
  }

  static Future removeEmployee(int id) async {
    await myDatabase.rawDelete('DELETE FROM Employees WHERE id = ?', [id]);
    getAllEmoloyee();
  }

  updateEmployee() {}
}
