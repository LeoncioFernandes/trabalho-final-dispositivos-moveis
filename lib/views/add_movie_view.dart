import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../controllers/movie_controller.dart';

class AddMovieView extends StatefulWidget {
  @override
  _AddMovieViewState createState() => _AddMovieViewState();
}

class _AddMovieViewState extends State<AddMovieView> {
  final MovieController _controller = MovieController();
  final _formKey = GlobalKey<FormState>();

  String urlImage = '';
  String title = '';
  String actor = '';
  String ageGroup = '';
  String genre = '';
  String duration = '';
  String score = '';
  String description = '';
  String releaseYear = '';

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newMovie = Movie(
        urlImage: urlImage,
        title: title,
        actor: actor,
        ageGroup: ageGroup,
        genre: genre,
        duration: duration,
        score: score,
        description: description,
        releaseYear: releaseYear,
      );
      await _controller.createMovie(newMovie);
      Navigator.pop(context, true);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Filme "${title}" adicionado com sucesso!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Filme')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'URL da Imagem'),
                onSaved: (value) => urlImage = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Título'),
                onSaved: (value) => title = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Atores'),
                onSaved: (value) => actor = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Classificação Etária'),
                onSaved: (value) => ageGroup = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Gênero'),
                onSaved: (value) => genre = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Duração'),
                onSaved: (value) => duration = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Pontuação'),
                onSaved: (value) => score = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  final numValue = double.tryParse(value.replaceAll(',', '.'));
                  if (numValue == null) {
                    return 'Por favor, insira um número válido';
                  }
                  if (numValue < 0 || numValue > 5) {
                    return 'A pontuação deve estar entre 0 e 5';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                onSaved: (value) => description = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
                maxLines: 3,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Ano de Lançamento'),
                onSaved: (value) => releaseYear = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Adicionar Filme'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
