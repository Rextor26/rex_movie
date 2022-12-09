import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rextor/domain/entities/movie/genre.dart';
import 'package:rextor/domain/entities/movie/movie_detail.dart';
import 'package:rextor/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rextor/presentation/bloc/movie_detail_page_bloc.dart';
import 'package:rextor/presentation/bloc/movie_detail_page_event.dart';
import 'package:rextor/presentation/bloc/movie_detail_page_state_management.dart';
import 'package:rextor/presentation/bloc/movie_page_bloc.dart';
import 'package:rextor/presentation/bloc/movie_page_event.dart';

import '../../bloc/movie_page_state_management.dart';

class MovieDetailPage extends StatefulWidget {
  static const initial_route = '/detail';

  final int id;
  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
   Future.microtask(() {
      context
          .read<RecommendationMoviesBloc>()
          .add(FetchMovieDataWithId(widget.id));
      context
          .read<MovieDetailBloc>()
          .add(FetchMovieDetailDataWithId(widget.id));
      context.read<MovieDetailBloc>().add(LoadWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MovieDetailBloc, MovieDetailState>(
        listener: (context, state) async {
          if (state.watchlistMessage ==
                  MovieDetailBloc.watchlistAddSuccessMessage ||
              state.watchlistMessage ==
                  MovieDetailBloc.watchlistRemoveSuccessMessage) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.watchlistMessage),
              duration: const Duration(seconds: 1),
            ));
          } else {
            await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(state.watchlistMessage),
                  );
                });
          }
        },
        listenWhen: (previousState, currentState) =>
            previousState.watchlistMessage != currentState.watchlistMessage &&
            currentState.watchlistMessage != '',
        builder: (context, state) {
          if (state.state == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.state == RequestState.Loaded) {
            final movie = state.movieDetail!;
            final status = state.isAddedToWatchlist;
            return SafeArea(
              child: DetailContent(
                movie,
                status,
              ),
            );
          } else {
            return const Center(child: Text("Failed to load"));
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final bool isAddedWatchlist;

  DetailContent(this.movie, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 4, 5, 6),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Center(
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                width: 90,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    movie.title,
                                     style: const TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                                ],
                              ),
                            ),
                            Center(
                              child: ElevatedButton(
                                 style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color.fromARGB(
                                                  255, 0, 11, 71),
                                            ),
                                onPressed: () async {
                                  if (!isAddedWatchlist) {
                                    context
                                      .read<MovieDetailBloc>()
                                      .add(AddWatchlist(movie));
                                  } else {
                                   
                                           context
                                      .read<MovieDetailBloc>().add(RemoveWatchlist(movie));
                                      
                                  }

                              

                                 
                                  
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Watchlist',style: TextStyle(color: Colors.white),),
                                    isAddedWatchlist
                                    
                                        ? Icon(Icons.check,)
                                        : Icon(Icons.add,),
                                    
                                  ],
                                ),
                              ),
                            ),
                             const SizedBox(
                                    height: 1,
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: const Text(
                                        'Rating',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )),
                            Row(
                              children: [
                                
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                     color: Colors.amber,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: const Text(
                                        'Overview',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )),
                            Text(
                              movie.overview,
                            ),
                            SizedBox(height: 16),
                             const SizedBox(height: 16,),
                                  const Text(
                                    'Recommendations',
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  BlocBuilder<RecommendationMoviesBloc, MovieState>(
                              builder: (context, state) {
                                if (state is LoadingData) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is LoadedData) {
                                  final result = state.result;
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                MovieDetailPage.initial_route,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: result.length,
                                    ),
                                  );
                                } else {
                                  return const Text('Failed');
                                }
                              },
                            ),

     
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
