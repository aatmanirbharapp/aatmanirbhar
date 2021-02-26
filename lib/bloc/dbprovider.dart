import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'aatmanirbhar.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE company('
          'id TEXT PRIMARY KEY,'
          'company_name TEXT,'
          'first_country TEXT,'
          'sector TEXT,'
          'made_in_india INTEGER'
          ')');
      await db.execute('CREATE TABLE product('
          'product_id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'company_id TEXT,'
          'product_name TEXT,'
          'first_country TEXT,'
          'manufacture TEXT,'
          'keywords TEXT,'
          'made_in_india TEXT,'
          'image TEXT'
          ')');
    });
  }

  // Insert employee on database
  createCompany(List companyList) async {
    final db = await database;

    Batch batch = db.batch();
    companyList.forEach((val) async {
      List record =
          await db.rawQuery('SELECT * FROM company where id = ?', [val['id']]);

      if (record.isEmpty) batch.insert('company', val);
    });

    await batch.commit();
  }

  // Insert employee on database
  createProduct(List productList) async {
    print("inside db provider");
    print(productList.length);
    final db = await database;
    Batch batch = db.batch();
    productList.forEach((val) async {
      List record = await db
          .rawQuery('SELECT * FROM product where image = ?', [val['image']]);

      if (record.isEmpty) batch.insert('product', val);
    });

    await batch.commit();
  }

  // Delete all employees
  Future<int> deleteAllEmployees() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM company');

    return res;
  }

  Future<List> companySearch(
      String name, String country, int make, String sector) async {
    print('inside search page');
    final db = await database;
    var res = List.empty();
    if (country.isEmpty && make == 2 && sector.isEmpty)
      res = await db.query('company',
          where: "company_name LIKE '%$name%'", limit: 50);
    else if (country.isNotEmpty && make == 2 && sector.isEmpty)
      res = await db.query('company',
          where: "company_name LIKE '%$name%' and  first_country = ?",
          whereArgs: [country],
          limit: 50);
    else if (country.isNotEmpty && make != 2 && sector.isEmpty)
      res = await db.query('company',
          where:
              "company_name LIKE '%$name%' and  first_country = ? and made_in_india = ?",
          whereArgs: [country, make],
          limit: 50);
    else
      res = await db.query('company',
          where:
              "company_name LIKE '%$name%' and  first_country = ? and made_in_india = ? and sector = ?",
          whereArgs: [country, make, sector],
          limit: 50);
    List list = res.isNotEmpty ? res.map((c) => c).toList() : [];

    return list;
  }

  Future<List> productSearch(String name, String country, int make,
      String manufacture, String keyword) async {
    final db = await database;
    var res = List.empty();
    if (country.isEmpty && make == 2 && manufacture.isEmpty)
      res = await db.query('product',
          where: "product_name LIKE '%$name%' or keywords LIKE '%$keyword%'",
          limit: 50);
    else if (country.isNotEmpty && make == 2 && manufacture.isEmpty)
      res = await db.query('product',
          where: "product_name LIKE '%$name%' and  first_country = ?",
          whereArgs: [country],
          limit: 50);
    else if (country.isNotEmpty && make != 2 && manufacture.isEmpty)
      res = await db.query('product',
          where:
              "product_name LIKE '%$name%' and  first_country = ? and made_in_india = ?",
          whereArgs: [country, make],
          limit: 50);
    else
      res = await db.query('product',
          where:
              "product_name LIKE '%$name%' and  first_country = ? and made_in_india = ? and sector = ?",
          whereArgs: [country, make, manufacture],
          limit: 50);

    List list = res.isNotEmpty ? res.map((c) => c).toList() : [];

    return list;
  }

  Future<List> getAllCompanySearch() async {
    print('inside search page');
    final db = await database;
    final res = await db.query('company',
        columns: ['company_name', 'first_country'], limit: 50);

    List list = res.isNotEmpty ? res.map((c) => c).toList() : [];
    print(list.length);

    return list;
  }
}
