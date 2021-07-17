import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hacker_news/src/bloc/comment/comment_bloc.dart';
import 'package:hacker_news/src/bloc/comment/comment_event.dart';
import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/screens/loading_container.dart';

class CommentItem extends StatelessWidget {

  final Map<int, Future<ItemModel?>> item;
  final int commentId;
  final int depth;

  const CommentItem({Key? key, required this.item, required this.commentId, required this.depth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CommentBLoc bloc = BlocProvider.of<CommentBLoc>(context);
    if(item[commentId]==null){  //to prevent continuous rebuild
      bloc.add(FetchCommentEvent(commentId));
    }

    return FutureBuilder(
     future: item[commentId],
      builder: (context, AsyncSnapshot<ItemModel?> snapshot) {
       if(!snapshot.hasData){
         return LoadingContainer();
       }
       if(snapshot.data == null){
         return Container();
       }
       final data = snapshot.data!;
        return buildCommnentItem(data);
      }
    );
  }

  Widget buildCommnentItem(ItemModel data) {
    String text = data.by == null ? "" : data.text == null ? "": data.text!;
    return Column(
      children: [
        ListTile(  //display resolved list. list returned from comment Screen
          contentPadding: EdgeInsets.only(left: depth *16, right: 16),
          title: Html(data: text,),
          subtitle: Text(data.by == null ? "Deleted": "By: ${data.by}"),
          ),
        ListView.builder(  //for each replies
          itemCount: data.kids!.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index){
            return CommentItem(item: item, commentId: data.kids![index], depth: depth+1,);  //item is previous item, CommentId is resolved list id..and bloc.add() will again be called
          },
        )
      ],
    );
  }
}
