import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLite {
  static Future createTables(sql.Database database) async {
    await database.execute('CREATE TABLE items(que TEXT, ans TEXT)');
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('calculator.db', version: 1,
        onCreate: (sql.Database db, version) async {
      await createTables(db);
    });
  }

  static Future<int> createItem(String que, String ans) async {
    final db = await SQLite.db();

    final data = {'que': que, 'ans': ans};
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLite.db();
    return db.query('items');
  }

  static Future<List<Map<String, dynamic>>> getItem(String que) async {
    final db = await SQLite.db();
    return db.query('items', where: 'que = ?', whereArgs: [que], limit: 1);
  }

  static Future<void> deleteItem(String que) async {
    final db = await SQLite.db();
    try {
      await db.delete('items', where: 'que = ?', whereArgs: [que]);
    } catch (err) {
      debugPrint('Something went wrong when deleting an item: $err');
    }
  }
}
