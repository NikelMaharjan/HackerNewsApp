abstract class CommentEvent{
  const CommentEvent();
}


class FetchCommentEvent extends CommentEvent{

  //for comment display, we need id

  final int id;
  const FetchCommentEvent(this.id);

}