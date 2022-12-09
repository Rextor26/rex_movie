import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rextor/common/state_enum.dart';
import 'package:rextor/presentation/bloc/movie_page_bloc.dart';
import 'package:rextor/presentation/bloc/movie_page_event.dart';
import 'package:rextor/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../bloc/movie_page_state_management.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
class MovieWatchlist_Page extends StatefulWidget {
  static const initial_route = '/movie_watchlist';

  @override
  _MovieWatchlist_PageState createState() => _MovieWatchlist_PageState();
}

class _MovieWatchlist_PageState extends State<MovieWatchlist_Page>
    with RouteAware {
  @override
  void initState() {
    super.initState();
      Future.microtask(() {
      context
          .read<WatchlistMovieBloc>()
          .add(const FetchMoviesData());
    
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
     context
        .read<WatchlistMovieBloc>()
        .add(const FetchMoviesData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist Movie'),backgroundColor: Color.fromARGB(255, 1, 6, 69)
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMovieBloc, MovieState>(
        builder: (context, state) {
          if (state is LoadingData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = state.result[index];
                return MovieCard(movie);
              },
              itemCount: state.result.length,
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
