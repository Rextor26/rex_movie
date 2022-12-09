import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rextor/common/state_enum.dart';
import 'package:rextor/presentation/bloc/movie_page_event.dart';
import 'package:rextor/presentation/bloc/movie_top_rated_notifier.dart';
import 'package:rextor/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../bloc/movie_page_bloc.dart';
import '../../bloc/movie_page_state_management.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const initial_route = '/movie_toprated';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
   Future.microtask(
        () => context.read<TopRatedMovieBloc>().add(const FetchMoviesData()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),backgroundColor: Color.fromARGB(255, 1, 6, 69),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMovieBloc, MovieState>
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
