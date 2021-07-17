import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/src/bloc/comment/comment_bloc.dart';
import 'package:hacker_news/src/bloc/comment/comment_state.dart';
import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/repo/repository.dart';
import 'package:hacker_news/src/widgets/comment_item.dart';

class CommentScreen extends StatelessWidget {
  final ItemModel item;

  const CommentScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Story Detail"),
      ),
      body: BlocProvider(
        create: (context) => CommentBLoc(RepositoryProvider.of<Repository>(context)),
          child: Builder(
            builder: (context){
             return _buildComments(context);
             },
    )));
  }

  Widget _buildComments(BuildContext context) {
 /*   final CommentBLoc bloc = BlocProvider.of<CommentBLoc>(context);
    item.kids!.forEach((element) {
      bloc.add(FetchCommentEvent(element));
    });*/

    /* for(var value in item.kids!) {
      bloc.add(FetchCommentEvent(value));
    }*/

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(item.title!, style: Theme.of(context).textTheme.headline6,),
        ),
        Divider(),
        BlocBuilder<CommentBLoc, CommentState>(
          builder: (BuildContext context, CommentState state) {
            print("Comment state is ${state.status}");

            return Flexible(
              fit: FlexFit.loose,
              child: ListView.builder(
                itemCount: item.kids!.length,
                physics: ClampingScrollPhysics(),
                // state.comments!.length,
                //shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      CommentItem(
                          item: state.comments!,
                          commentId: item.kids![index],
                        depth:1,
                 ),
                      Divider(),
                    ],
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }
}
