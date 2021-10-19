import 'package:flutter/material.dart';
import 'package:flutter_bloc_learn/src/blocs/movies_bloc.dart';
import 'package:flutter_bloc_learn/src/models/item_model.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key, required this.bloc}) : super(key: key);

  final MoviesBloc bloc;
  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  void initState() {
    super.initState();
    widget.bloc.init();
    widget.bloc.fetchAllMovies();
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: StreamBuilder(
        stream: widget.bloc.allMovies,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return (GridView.builder(
        itemCount: snapshot.data?.results.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                'https://image.tmdb.org/t/p/w185${snapshot.data?.results[index].posterPath}',
                fit: BoxFit.cover,
              ),
              onTap: () => openDetailPage(snapshot.data!, index),
            ),
          );
        }));
  }

  openDetailPage(ItemModel data, int index) {
    Navigator.pushNamed(context, 'movieDetail', arguments: data.results[index]);
  }
}
