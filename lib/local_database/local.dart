import 'package:mocko_app/local_database/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDataBase {
  static final LocalDataBase getInstance = LocalDataBase._();
  factory LocalDataBase() {
    return getInstance;
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("company.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const intType = "INTEGER DEFAULT 0";
    const textType = "TEXT NOT NULL";
    await db.execute('''
    CREATE TABLE $tableName (
      ${CachedCompaniesRows.id} $idType,
      ${CachedCompaniesRows.companyName} $textType,
      ${CachedCompaniesRows.companyId} $intType,
      ${CachedCompaniesRows.isFavourite} $intType,
      ${CachedCompaniesRows.logoUrl} $textType


    )
''');
  }

  LocalDataBase._();

//<--------------------------------------- EDIT DATES FROM DATABASE ------------------------------------>
  static Future<CachedCompanies> insert(CachedCompanies cachedCompanies) async {
    final db = await getInstance.database;
    final id = await db.insert(tableName, cachedCompanies.toJson());
    return cachedCompanies.copyWith(id: id);
  }

  static Future<int> deleteAllTodos() async {
    final db = await getInstance.database;
    return await db.delete(tableName);
  }

  static Future<int> deleteByID(int isDone) async {
    final db = await getInstance.database;
    final t = await db.delete(tableName,
        where: "${CachedCompaniesRows.id} = ?", whereArgs: [isDone]);
    if (t > 0) {
      return t;
    } else {
      return -1;
    }
  }

  static Future<List<CachedCompanies>> getAllTodos() async {
    final db = await getInstance.database;
    final result = await db.query(tableName);
    return result.map((json) => CachedCompanies.fromJson(json)).toList();
  }

  static Future<int> editTodo({required name, required id}) async {
    Map<String, Object?> row = {
      CachedCompaniesRows.companyName: name,
    };

    final db = await getInstance.database;
    return await db.update(
      tableName,
      row,
      where: '${CachedCompaniesRows.id} = ?',
      whereArgs: [id],
    );
  }
}
