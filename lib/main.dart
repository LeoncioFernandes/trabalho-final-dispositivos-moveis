import 'package:flutter/material.dart';
import 'views/movie_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Filmes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MovieListView(),
    );
  }
}
