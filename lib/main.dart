import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/src/repo/repository.dart';
import 'package:hacker_news/src/screens/news_screen.dart';


void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => Repository(),
      child: MaterialApp(
        title: 'Hacker News',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NewsScreen(),
      ),
    );
  }
}

