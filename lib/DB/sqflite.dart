
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class DataBasesLocal {
Future<Database> initializeDB() async {
  String path = await getDatabasesPath();
  return openDatabase(
    join(path, 'DT_database.db'),
    onCreate: (database, version) async {

      await database.execute(
        'CREATE TABLE Tasks(id INTEGER PRIMARY KEY ,  isDone INTEGER  ,  title TEXT  )',
      );

    },
    version: 1,
  );
}
}
