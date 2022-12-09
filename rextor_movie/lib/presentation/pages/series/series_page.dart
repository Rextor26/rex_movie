import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/presentation/bloc/series/series_even.dart';
import 'package:rextor/presentation/bloc/series/series_bloc.dart';
import 'package:rextor/presentation/bloc/series/series_state_management.dart';
import 'package:rextor/presentation/pages/about_page.dart';
import 'package:rextor/presentation/pages/movie/movie_home_page.dart';
import 'package:rextor/presentation/pages/series/series_today_page.dart';
import 'package:rextor/presentation/pages/series/series_popular_page.dart';
import 'package:rextor/presentation/pages/series/series_search_page.dart';
import 'package:rextor/presentation/pages/series/series_top_rated_page.dart';
import 'package:rextor/presentation/pages/series/series_detail_page.dart';
import 'package:rextor/presentation/pages/series/series_on_air_page.dart';
import 'package:rextor/presentation/pages/series/series_watchlist_page.dart';
import 'package:flutter/material.dart';


const String BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/w500';
class SeriesPage extends StatefulWidget {
  static const initial_route = '/homePage_Seriess';

  const SeriesPage({Key? key}) : super(key: key);

  @override
  _SeriesPageState createState() => _SeriesPageState();
}

class _SeriesPageState extends State<SeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>{
      context.read<seriesPopularBloc>().add(const FetchTvseriesData()),
      context.read<TopratedSeriesBloc>().add(const FetchTvseriesData()),
      context.read<SeriesTodayBloc>().add(const FetchTvseriesData()),
      context.read<SeriesOnAirBloc>().add(const FetchTvseriesData())
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/ui.jpg'),
              ),
              accountName: Text('Taufiq.J.K'),
                accountEmail: Text('taufiq@gmail.com')),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movie'),
              onTap: () => {
                // Navigator.pop(context)
                Navigator.pushNamed(context, HomeMoviePage.initial_route)
              },
            ),
          
            ListTile(
              leading: const Icon(Icons.save_alt_outlined),
              title: const Text('Watchlist Series'),
              onTap: () {
                // Navigator.pushNamed(context, WatchlistPage.routeName);
                Navigator.pushNamed(context, WatchListSeriesPage.initial_route);
              },
            ),
            const ListTile(
              title: Text('Informasi',style: TextStyle(fontWeight: FontWeight.bold),),
             
            ),
            ListTile(
              leading: const Icon(Icons.info_outlined),
              title: const Text('About'),
              onTap: () {
                Navigator.pushNamed(context, AboutPage.initial_route);
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 3, 71),
        title: const Text("Rextor Movie", style: TextStyle(fontSize: 15),),
        leading: 
          IconButton(
            onPressed: () {
              
              Navigator.pushNamed(context, SearchSeriesPage.initial_route);
            },
            icon: const Icon(Icons.search)
          ),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(context, TopRatedSeriesPage.initial_route),
              ),
              BlocBuilder<TopratedSeriesBloc, SeriesStateManagement>
              (builder: (context, state) {
                if (state is LoadingDataSeries){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }else if (state is LoadedDataSeries){
                  final result = state.result;
                  return SeriesList(result);
                }else{
                  return const Text("Failed to load");
                }
                
              }),

              _buildSubHeading(
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(context, PopularSeriesPage.initial_route);
                }
              ),
              BlocBuilder<seriesPopularBloc, SeriesStateManagement>(
                builder: (context, state) {
                if (state is LoadingDataSeries){
                  return const Center(
                      child: CircularProgressIndicator(),
                    );
                }else if (state is LoadedDataSeries){
                  final result = state.result;
                  return SeriesList(result);
                }else{
                  return const Text("Failed to load");
                }
                

              }),
              _buildSubHeading(
                title: 'Series On The Air',
                onTap: () {
                  Navigator.pushNamed(context, SeriesOnTheAirPage.initial_route);
                }
              ),       
                     BlocBuilder<SeriesOnAirBloc, SeriesStateManagement>(
                builder: (context, state) {
                if (state is LoadingDataSeries){
                  return const Center(
                      child: CircularProgressIndicator(),
                    );
                }else if (state is LoadedDataSeries){
                  final result = state.result;
                  return SeriesList(result);
                }else{
                  return const Text("Failed to load");
                }
                

              }),
              _buildSubHeading(
                title: 'Series Today',
                onTap: () {
                  Navigator.pushNamed(context, AiringTodayPage.initial_route);
                }
              ),
                   BlocBuilder<SeriesTodayBloc, SeriesStateManagement>(
                builder: (context, state) {
                if (state is LoadingDataSeries){
                  return const Center(
                      child: CircularProgressIndicator(),
                    );
                }else if (state is LoadedDataSeries){
                  final result = state.result;
                  return SeriesList(result);
                }else{
                  return const Text("Failed to load");
                }
                

              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
        
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: const [Text('See more'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        )
      ],
    );
  }
}

class SeriesList extends StatelessWidget {
  final List<Series> tv;

  SeriesList(this.tv);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tv.length,
        itemBuilder: (context, index) {
          final series = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                debugPrint('${series.id}');
                Navigator.pushNamed(context, SeriesDetailPage.initial_route,
                    arguments: series.id);
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${series.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
