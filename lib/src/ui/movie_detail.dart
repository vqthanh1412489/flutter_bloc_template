import 'package:flutter/material.dart';
import 'package:flutter_bloc_learn/src/blocs/movie_detail_bloc.dart';
import 'package:flutter_bloc_learn/src/models/trailer_model.dart';

class MovieDetail extends StatefulWidget {
  final MovieDetailBloc bloc;
  final String posterUrl;
  final String description;
  final String releaseDate;
  final String title;
  final dynamic voteAverage;
  final int movieId;

  const MovieDetail(this.bloc, this.title, this.posterUrl, this.description,
      this.releaseDate, this.voteAverage, this.movieId,
      {Key? key})
      : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  void initState() {
    super.initState();
    widget.bloc.init();
    widget.bloc.fetchTrailersById(widget.movieId);
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                  "https://image.tmdb.org/t/p/w500${widget.posterUrl}",
                  fit: BoxFit.cover,
                )),
              ),
            ];
          },
          body: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(margin: const EdgeInsets.only(top: 5.0)),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 8.0, bottom: 8.0)),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 1.0, right: 1.0),
                      ),
                      Text(
                        "${widget.voteAverage}",
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      ),
                      Text(
                        widget.releaseDate,
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 8.0, bottom: 8.0)),
                  Text(widget.description),
                  Container(
                      margin: const EdgeInsets.only(top: 8.0, bottom: 8.0)),
                  const Text(
                    "Trailer",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 8.0, bottom: 8.0)),
                  StreamBuilder(
                    stream: widget.bloc.movieTrailers,
                    builder: (BuildContext context,
                        AsyncSnapshot<TrailerModel> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.results.isNotEmpty) {
                          return trailerLayout(snapshot.data!);
                        } else {
                          return noTrailer(snapshot.data!);
                        }
                      } else {
                        debugPrint(snapshot.connectionState.toString());
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget noTrailer(TrailerModel data) {
    return const Center(
      child: Text("No trailer available"),
    );
  }

  Widget trailerLayout(TrailerModel data) {
    if (data.results.length > 1) {
      return Row(
        children: <Widget>[
          trailerItem(data, 0),
          trailerItem(data, 1),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          trailerItem(data, 0),
        ],
      );
    }
  }

  trailerItem(TrailerModel data, int index) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(5.0),
            height: 100.0,
            color: Colors.grey,
            child: const Center(child: Icon(Icons.play_circle_filled)),
          ),
          Text(
            data.results[index].name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
