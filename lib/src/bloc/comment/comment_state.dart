import 'package:hacker_news/src/models/item_model.dart';

enum CommentStatus{initial, loading, loaded, error}

class CommentState{
  final CommentStatus status;
  //final List<ItemModel>? comments;

  final Map<int, Future<ItemModel?>>? comments;  //to display comment in hierarchical order

  final String? message;

  const CommentState({required this.status, this.comments = const {}, this.message});  //if comments is null, empty list will be assigned


}