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
    String path = await getDatabasesPath();
    String fullpath = join(path, 'proNotes.db');
    Database mydb = await openDatabase(fullpath, onCreate: _onCreate, version: 1, onUpgrade: _onUpdate);

    return mydb;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
        create table notes (
          id INTEGER not null primary key AUTOINCREMENT,
          note TEXT not null,
          title TEXT not null,
          color TEXT not null,
          date_time TEXT not null 
        )
    ''');
  }

  _onUpdate(Database db, int oldversion, int newversion) async {
    await db.execute("alter table notes add column color TEXT");
  }

  Future<List<Map>> select(String query) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(query);
    return response;
  }

  Future<int> insert(String query) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(query);
    return response;
  }

  Future<int> update(String query) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(query);
    return response;
  }

  Future<int> delete(String query) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(query);
    return response;
  }

  dropDatabase() async{
    String path = await getDatabasesPath();
    String fullpath = join(path, 'proNotes.db');
    databaseFactory.deleteDatabase(fullpath);
  }
}
