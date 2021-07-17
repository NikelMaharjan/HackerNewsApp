import 'package:hacker_news/src/core/sources.dart';
import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/repo/new_api_provider.dart';
import 'package:hacker_news/src/repo/news_db_provider.dart';

import 'new_api_provider.dart';

//decide from where data to give api or database

class Repository {
/*  final NewsDbProvider dbProvider = NewsDbProvider();
  final NewsApiProvider apiProvider = NewsApiProvider();

  Future<List<int>> fetchTopIDs() async{
    //need to do database later
    return apiProvider.fetchTopIDs();
  }

  Future<ItemModel?> fetchItem (int id) async{  //we use abstract class. if there are more providers then we need to refactor the code everytime or issue may come
    ItemModel? item = await dbProvider.fetchItem(id);
    if(item != null) return item;


    item = await apiProvider.fetchItem(id);
    if(item!=null){
      dbProvider.insertItem(item);
    }
    return item;

  }*/

  final NewsApiProvider apiProvider = NewsApiProvider();
  final NewsDbProvider dbProvider = NewsDbProvider();

  late final List<Source> sources = [
    dbProvider,
    apiProvider
  ];

  late final List<Cache> caches = [
    dbProvider,
  ];

  Future<List<int>> fetchTopIDs() async {
    return sources[1].fetchTopIDs(); //index 1 is newsApi provider
  }

  Future<ItemModel?> fetchItem(int id) async {
    ItemModel? item;
    Source? source; //another solution for not inserting item from DB into DB
    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    if (item != null) {
      for (var cache in caches) {
        if (source is NewsApiProvider) {
          cache.insertItem(item);
        }
      }
    }

    return item;
  }

  Future<void> clearData() async{
    await dbProvider.clearData();
  }
}
