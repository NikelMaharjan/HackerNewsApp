

import 'package:bloc/bloc.dart';
import 'package:hacker_news/src/bloc/comment/comment_event.dart';
import 'package:hacker_news/src/bloc/comment/comment_state.dart';
import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/repo/repository.dart';

class CommentBLoc extends Bloc<CommentEvent, CommentState>{
  final Repository repo;
  CommentBLoc(this.repo) :
        super(CommentState(status: CommentStatus.initial));

  @override
  Stream<CommentState> mapEventToState(CommentEvent event) async* {
    if(event is FetchCommentEvent){
     /* yield(CommentState(status: CommentStatus.loading));*/
      //final item = await repo.fetchItem(event.id);

      /*  if(item==null){
        yield(CommentState(status: CommentStatus.error, message: "Could not fetch item"));
      }*/
      //yield loadComment(item) ;
/*
      if(state.comments![event.id] != null){
        return;
      }*/
      final item =  repo.fetchItem(event.id);

      yield loadComment(item, event.id) ;
    }
  }

  CommentState loadComment(Future<ItemModel?> item, int id) {
  /*  var list = List.from(state.comments!).cast<ItemModel>(); //state.comments will have previous list of comments
       if(item!=null){
      list.add(item);
    }*/
    Map<int, Future<ItemModel?>> map = Map.from(state.comments!);
  //  map[id] = item
    map.putIfAbsent(id, () => item);



    return CommentState(status: CommentStatus.loaded, comments: map);
  }


}