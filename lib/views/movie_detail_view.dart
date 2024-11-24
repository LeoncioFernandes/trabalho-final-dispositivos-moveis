import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../controllers/movie_controller.dart';

class MovieDetailView extends StatefulWidget {
  final Movie movie;

  MovieDetailView({required this.movie});

  @override
  _MovieDetailViewState createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  final MovieController _controller = MovieController();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _urlImageController;
  late TextEditingController _titleController;
  late TextEditingController _actorController;
  late TextEditingController _ageGroupController;
  late TextEditingController _genreController;
  late TextEditingController _durationController;
  late TextEditingController _scoreController;
  late TextEditingController _descriptionController;
  late TextEditingController _releaseYearController;

  @override
  void initState() {
    super.initState();
    _urlImageController = TextEditingController(text: widget.movie.urlImage);
    _titleController = TextEditingController(text: widget.movie.title);
    _actorController = TextEditingController(text: widget.movie.actor);
    _ageGroupController = TextEditingController(text: widget.movie.ageGroup);
    _genreController = TextEditingController(text: widget.movie.genre);
    _durationController = TextEditingController(text: widget.movie.duration);
    _scoreController = TextEditingController(text: widget.movie.score);
    _descriptionController =
        TextEditingController(text: widget.movie.description);
    _releaseYearController =
        TextEditingController(text: widget.movie.releaseYear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Filme'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(_urlImageController.text,
                  height: 200, width: double.infinity, fit: BoxFit.cover),
              SizedBox(height: 20),
              TextFormField(
                controller: _urlImageController,
                decoration: InputDecoration(labelText: 'URL da Imagem'),
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _actorController,
                decoration: InputDecoration(labelText: 'Atores'),
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _ageGroupController,
                decoration: InputDecoration(labelText: 'Classificação Etária'),
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _genreController,
                decoration: InputDecoration(labelText: 'Gênero'),
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _durationController,
                decoration: InputDecoration(labelText: 'Duração'),
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _scoreController,
                decoration: InputDecoration(labelText: 'Pontuação'),
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
                maxLines: 3,
              ),
              TextFormField(
                controller: _releaseYearController,
                decoration: InputDecoration(labelText: 'Ano de Lançamento'),
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    widget.movie.urlImage = _urlImageController.text;
                    widget.movie.title = _titleController.text;
                    widget.movie.actor = _actorController.text;
                    widget.movie.ageGroup = _ageGroupController.text;
                    widget.movie.genre = _genreController.text;
                    widget.movie.duration = _durationController.text;
                    widget.movie.score = _scoreController.text;
                    widget.movie.description = _descriptionController.text;
                    widget.movie.releaseYear = _releaseYearController.text;
                    await _controller.updateMovie(
                        widget.movie.id!, widget.movie);
                    Navigator.pop(context, true);
                  }
                },
                child: Text('Atualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _urlImageController.dispose();
    _titleController.dispose();
    _actorController.dispose();
    _ageGroupController.dispose();
    _genreController.dispose();
    _durationController.dispose();
    _scoreController.dispose();
    _descriptionController.dispose();
    _releaseYearController.dispose();
    super.dispose();
  }
}
