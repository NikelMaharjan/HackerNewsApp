import 'dart:io';

import 'package:hacker_news/src/core/constants.dart';
import 'package:hacker_news/src/core/sources.dart';
import 'package:hacker_news/src/models/item_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import "package:path/path.dart" as path;

class NewsDbProvider implements Source, Cache {
  Database? _db; //since DB works with asycn so we cant work with constructor

  NewsDbProvider() {
    _init();
  }

  Future<void> _init() async {
    Directory dir = await getApplicationDocumentsDirectory();   //internal storage access give/ folder reference
    final dbPath = path.join(dir.path, DB_NAME); //it will create file and hold the path

    _db = await openDatabase(dbPath, version: 1,
        onCreate: (Database newDb, int version) {//oncreate will call if database is not created. we cant use _db here since it is in await
      Batch batch = newDb.batch(); //batch will collect sql commands first and execute one by one
      batch.execute("""
        CREATE TABLE $Item_Table (
              id INTEGER PRIMARY KEY,
              by TEXT,
              descendants INTEGER,
              parent INTEGER,
              deleted INTEGER,
              dead INTEGER,
              kids BLOB,
              score INTEGER,
              time INTEGER,
              title TEXT,
              type TEXT,
              url TEXT          
        )     
        """);
      batch.commit();
    });
  }


  Future<int> insertItem(ItemModel item) async {
    if (_db == null) await _init();
    return _db!.insert(Item_Table, item.toDB());
  }

  @override
  Future<ItemModel?> fetchItem(int id) async {
    if (_db == null) await _init();
    //final data = await _db!.rawQuery("SELECT * FROM $Item_Table where id = $id");
    final data = await _db!.query(
        Item_Table,
        where: "id =?",     //dont use this if need to fetch all
      //  columns: ['id','descendants'],
        whereArgs: [id],    //dont use this if need to fetch all
    );
    if(data.length!=1) return null;
    return ItemModel.fromDB(data.first);
  }

  @override
  Future<List<int>> fetchTopIDs() async {
    // TODO: implement fetchTopIDs
   return [];
  }
}
