import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rextor/common/state_enum.dart';
import 'package:rextor/domain/entities/movie/genre.dart';
import 'package:rextor/domain/entities/series/season.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/domain/entities/series/series_detail.dart';
import 'package:rextor/domain/usecases/series/get_series_remove_series_watchlist.dart';
import 'package:rextor/presentation/bloc/series/series_detail_bloc.dart';
import 'package:rextor/presentation/bloc/series/series_detail_event.dart';
import 'package:rextor/presentation/bloc/series/series_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:rextor/presentation/bloc/series/series_detail_state_management.dart';
import 'package:rextor/presentation/bloc/series/series_even.dart';
import 'package:rextor/presentation/bloc/series/series_bloc.dart';
import 'package:rextor/presentation/bloc/series/series_state_management.dart';

class SeriesDetailPage extends StatefulWidget {
  static const initial_route = '/detai_Series';
  final int id;
  const SeriesDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _SeriesDetailPageState createState() => _SeriesDetailPageState();
}

class _SeriesDetailPageState extends State<SeriesDetailPage> {
  @override
  void initState() {
    super.initState();
   Future.microtask(() {
      context
          .read<RecommendationTvseriesBloc>()
          .add(FetchTvseriesDataWithId(widget.id));
      context
          .read<SeriesDetailBloc>()
          .add(FetchSeriesDetailById(widget.id));
      context.read<SeriesDetailBloc>().add(LoadWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SeriesDetailBloc, SeriesDetailState>(
        listener: (context, state) async {
          if (state.watchlistMessage ==
                  SeriesDetailBloc.watchlistAddSuccessMessage ||
              state.watchlistMessage ==
                  SeriesDetailBloc.watchlistRemoveSuccessMessage) {
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
        listenWhen: (previousState, currentState) {
          return previousState.watchlistMessage !=
                  currentState.watchlistMessage &&
              currentState.watchlistMessage != '';
        },
        builder: (context, state) {
          if (state.state == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.state == RequestState.Loaded) {
            final seriesDetail = state.tvseriesDetail!;
            final isAddedWatchlistSeries = state.isAddedToWatchlist;
            return SafeArea(
              child: DetailsSeries_Page(
                seriesDetail,
                isAddedWatchlistSeries,
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

class DetailsSeries_Page extends StatelessWidget {
  final SeriesDetail seriesDetail;
  final bool isAddedWatchlistSeries;
  DetailsSeries_Page(this.seriesDetail, this.isAddedWatchlistSeries);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${seriesDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 10),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
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
                                            'https://image.tmdb.org/t/p/w500${seriesDetail.posterPath}',
                                        width: 90,
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                            Center(child: Text(seriesDetail.name, style: const TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),)),
                             Center(child: Text(_showGenres(seriesDetail.genres))),
                            Center(
                              child: ElevatedButton(
                                 style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 0, 11, 71),
                                            ),
                                  onPressed: () async {
                                    if (!isAddedWatchlistSeries) {
                                      context
                                      .read<SeriesDetailBloc>()
                                      .add(AddWatchlistSeries(seriesDetail));
                                    } else {
                                      context
                                      .read<SeriesDetailBloc>()
                                      .add(RemoveSeriesWatchlist(seriesDetail));
                                    }
                                   
                                    
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      isAddedWatchlistSeries
                                          ? const Icon(Icons.check)
                                          : const Icon(Icons.add),
                                      const Text('Watchlist')
                                    ],
                                  )),
                            ),
                           
                                                                Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: const Text(
                                        "Rating",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: seriesDetail.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.yellow
                                  ),
                                  itemSize: 24,
                                ),
                                
                                Text('${seriesDetail.voteAverage}')
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Overview',
                              style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      
                            ),
                            Text(seriesDetail.overview),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Seasons',
                            style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      
                            ),
                            _showSeason(context, seriesDetail.seasons),
                            Text(
                              'Recommendations',
                              style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      
                            ),
                             BlocBuilder<RecommendationTvseriesBloc,
                                SeriesStateManagement>
                            (
                              builder: (context, state) {
                                if (state is LoadingDataSeries) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is LoadedDataSeries) {
                                  final result = state.result;
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvseries = result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                                 Navigator.pushReplacementNamed(
                                                  context,
                                                  SeriesDetailPage.initial_route,
                                                  arguments:tvseries.id);
                                             
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tvseries.posterPath}',
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
                    )
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _showSeason(BuildContext context, List<Season> season) {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: season.length,
              itemBuilder: (context, index) {
                return Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 7),
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color
                                                                    .fromARGB(
                                                                255, 0, 11, 71),
                                                      ),
                                                      onPressed: () {},
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                              season[index]
                                                              .name)
                                                        ],
                                                      )),
                                                );
              }),
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
}
