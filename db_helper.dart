import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/account.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(join(dbPath, 'haal_khata.db'), onCreate: (db, version) {
      return db.execute('CREATE TABLE accounts(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, amount REAL, isSupplier INTEGER, imagePath TEXT)');
    }, version: 1);
  }

  static Future<void> insertAccount(Account acc) async {
    final db = await DBHelper.database();
    await db.insert('accounts', acc.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Account>> getAccounts({required bool isSupplier}) async {
    final db = await DBHelper.database();
    final List<Map<String, dynamic>> maps = await db.query('accounts', where: 'isSupplier=?', whereArgs: [isSupplier?1:0]);
    return maps.map((m) => Account.fromMap(m)).toList();
  }
}