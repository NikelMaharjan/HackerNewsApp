import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/src/bloc/news/news_bloc.dart';
import 'package:hacker_news/src/bloc/news/news_event.dart';
import 'package:hacker_news/src/bloc/news/news_state.dart';
import 'package:hacker_news/src/repo/repository.dart';
import 'package:hacker_news/src/widgets/news_item.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {

    return BlocProvider(
      create: (context) => NewsBloc(RepositoryProvider.of<Repository>(context)),
      child: Builder( builder: (context) {
        final NewsBloc bloc = BlocProvider.of<NewsBloc>(context);
        bloc.add(FetchStoriesEvent());
          return Scaffold(
            appBar: AppBar(
              title: Text("Trending News"),
            ),
            body: _buildNewsList(context, bloc),
          );
        }
      ),
    );
  }

  Widget _buildNewsList(BuildContext context, NewsBloc bloc) {
    return BlocConsumer<NewsBloc, NewsState>(
      listener: (BuildContext context, NewsState state){
        if(state.status == NewsStatus.error){
          ScaffoldMessenger.of(context).
          showSnackBar(SnackBar(content: Text(state.message!))); //is not recommended to use inside bloc builder
        }
      },
      builder: (BuildContext context, NewsState state) {
        print("News state is${state.status}");
        if (state.status == NewsStatus.initial ||
            state.status == NewsStatus.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.status == NewsStatus.error) {

          return Center(child: Text("${state.message}"));
        }
        return RefreshIndicator(
          onRefresh: () async {
            bloc.add(RefreshEvent());
            bloc.add(FetchStoriesEvent());   //this will rebuild build function
          },
          child: ListView.builder(
            itemCount: state.ids!.length,
            itemBuilder: (BuildContext context, int index) {
              //we displayed ids previously. so We can display ids with this method?
              print("Item id ${state.ids![index]} and $index");
              final item = bloc.getItemById(state.ids![index]);
              return NewsItem(
                  item: item); //we provide future to NewsItem since getItemByID is future
            },
          ),
        );
      },
    );
  }
}
