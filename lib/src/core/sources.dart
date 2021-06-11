

import 'package:hacker_news/src/models/item_model.dart';

abstract class Source {

  Future<List<int>> fetchTopIDs();

  Future<ItemModel?> fetchItem(int id);

}

abstract class Cache{
  Future<int> insertItem(ItemModel item);   //insertItem method  of db provider. since we wont be using that in api provider. so we use here
}




