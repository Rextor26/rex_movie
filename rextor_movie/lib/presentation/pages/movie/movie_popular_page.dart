import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rextor/presentation/bloc/movie_page_event.dart';
import 'package:rextor/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';

import '../../bloc/movie_page_bloc.dart';
import '../../bloc/movie_page_state_management.dart';

class MoviePopularPage extends StatefulWidget {
  static const initial_route = '/movie_popular';

  @override
  _MoviePopularPageState createState() => _MoviePopularPageState();
}

class _MoviePopularPageState extends State<MoviePopularPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<PopularMovieBloc>().add(const FetchMoviesData()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 1, 6, 69),
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMovieBloc, MovieState>
        (
          builder: (context, state) {
            if (state is LoadingData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedData) {
              final result = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = result[index];
                  return MovieCard(movie);
                },
                itemCount: result.length,
              );
            } else if (state is ErrorData) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
