import 'package:bloc/bloc.dart';
import 'package:hacker_news/src/bloc/news/news_event.dart';
import 'package:hacker_news/src/bloc/news/news_state.dart';
import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/repo/repository.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState>{
  NewsBloc(this.repo) : super(NewsState(status: NewsStatus.initial));  //if there is no values,data, this will call/show
  final Repository repo;

  //dependency injection will provide dependency. We need repository to work with NewsBloc. Since NewsBloc is depended on repository.
  //we provide dependency using constructor


  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
   if(event is FetchStoriesEvent){
     yield(NewsState(status: NewsStatus.loading)); //first time call
     final id = await repo.fetchTopIDs();
     if(id.isEmpty){
       yield(NewsState(status: NewsStatus.error,
           message: "Could not fetch news, please try again"));
     }else{
       yield(NewsState(status: NewsStatus.loaded,
           ids: id));
     }
   }

   if(event is RefreshEvent){
     //clear database
     await repo.clearData();

   }
  }

  Future<ItemModel?> getItemById(int id) async {
   return await repo.fetchItem(id);

  }



}