

enum NewsStatus{ initial, loading, loaded, error} //enum holds set of values defined by us. like bool have 2 values. true and false.
//{initial, authentication, unauthentication}




class NewsState{
  final NewsStatus status;
  final List<int>? ids;
  final String? message;
  const NewsState({required this.status, this.message, this.ids});
}