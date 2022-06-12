import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'simplenote.db');
    Database myDb = await openDatabase(path, onCreate: (db, version) async {
      Batch batch = db.batch();

      batch.execute('''
          CREATE TABLE "notes" (
            "id" TEXT NOT NULL ,
            "creationdate" TEXT NOT NULL,
            "title" TEXT NOT NULL ,
            "note" TEXT NOT NULL ,
            "colorid" TEXT NOT NULL 
          )
        ''');

      await batch.commit();
      print('Created db ');
    }, version: 1);

    return myDb;
  }

  deleteDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'simplenote.db');
    databaseFactory.deleteDatabase(path);
  }

  readData(String sql) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.query(sql);
    return response;
  }

  insertData(String table,Map<String,String> item) async {
    Database? myDb = await db;
    int response = await myDb!.insert(table,item);
    return response;
  }

  updateData(String sql , Map<String, Object?> map,String id) async {
    Database? myDb = await db;
    int response = await myDb!.update(sql, map,
   where: 'id = ?', whereArgs: [id]);
    return response;
  }

  deleteData(String id) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete('DELETE FROM notes WHERE id = ?'  , [id]);
    return response;
  }
}
