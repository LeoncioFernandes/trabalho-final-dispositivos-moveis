import 'package:cinep/views/add_movie_view.dart';
import 'package:flutter/material.dart';
import '../controllers/movie_controller.dart';
import '../models/movie.dart';
import 'movie_detail_view.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieListView extends StatefulWidget {
  @override
  _MovieListViewState createState() => _MovieListViewState();
}

class _MovieListViewState extends State<MovieListView> {
  final MovieController _controller = MovieController();
  List<Movie> _movies = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    final movies = await _controller.getAllMovies();
    setState(() {
      _movies = movies;
    });
  }

  Future<void> _searchMovies(String query) async {
    if (query.isEmpty) {
      await _loadMovies();
    } else {
      final movies = await _controller.searchMovies(query);
      setState(() {
        _movies = movies;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filmes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
                _searchMovies(value);
              },
              decoration: const InputDecoration(
                labelText: 'Buscar filmes',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _movies.isEmpty
                ? Center(
                    child: Text(
                      'Filme "$_searchQuery" não encontrado!',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: _movies.length,
                    itemBuilder: (context, index) {
                      final movie = _movies[index];
                      return Dismissible(
                        key: Key(movie.id.toString()),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) async {
                          await _controller.deleteMovie(movie.id!);
                          setState(() {
                            _movies.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Filme "${movie.title}" removido com sucesso'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Image.network(movie.urlImage,
                              width: 45, height: 100, fit: BoxFit.contain),
                          title: Text(movie.title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(movie.genre),
                              SizedBox(height: 4),
                              RatingBarIndicator(
                                rating: double.parse(
                                    movie.score.replaceAll(',', '.')),
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 15.0,
                                direction: Axis.horizontal,
                              ),
                            ],
                          ),
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailView(movie: movie),
                              ),
                            );
                            if (result == true) {
                              await _loadMovies();
                            }
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMovieView()),
          );
          if (result == true) {
            await _loadMovies();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Novo filme adicionado com sucesso!'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
