import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rextor/common/ssl.dart';
import 'package:rextor/firebase_options.dart';
import 'package:rextor/presentation/bloc/movie_detail_page_bloc.dart';
import 'package:rextor/presentation/bloc/movie_page_bloc.dart';
import 'package:rextor/presentation/bloc/search_page_bloc.dart';
import 'package:rextor/presentation/bloc/series/series_detail_bloc.dart';
import 'package:rextor/presentation/bloc/series/series_search_bloc.dart';
import 'package:rextor/presentation/bloc/series/series_bloc.dart';
import 'package:rextor/presentation/pages/about_page.dart';
import 'package:rextor/presentation/pages/movie/movie_detail_page.dart';
import 'package:rextor/presentation/pages/movie/movie_home_page.dart';
import 'package:rextor/presentation/pages/movie/movie_popular_page.dart';
import 'package:rextor/presentation/pages/movie/movie_search_page.dart';
import 'package:rextor/presentation/pages/movie/movie_top_rated_page.dart';
import 'package:rextor/presentation/pages/series/series_today_page.dart';
import 'package:rextor/presentation/pages/series/series_popular_page.dart';
import 'package:rextor/presentation/pages/series/series_search_page.dart';
import 'package:rextor/presentation/pages/series/series_top_rated_page.dart';
import 'package:rextor/presentation/pages/series/series_detail_page.dart';
import 'package:rextor/presentation/pages/series/series_on_air_page.dart';
import 'package:rextor/presentation/pages/series/series_page.dart';
import 'package:rextor/presentation/pages/series/series_watchlist_page.dart';
import 'package:rextor/presentation/pages/movie/movie_watchlist_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rextor/injection.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  await HttpSSLPinning.init();
  di.init();
  runApp(MyApp());
}


final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_)=>di.locator<MovieBloc>(),),
        BlocProvider(create: (_)=>di.locator<MovieDetailBloc>(),),
        BlocProvider(create: (_)=>di.locator<RecommendationMoviesBloc>()),
        BlocProvider(create: (_)=>di.locator<TopRatedMovieBloc>()),
        BlocProvider(create: (_)=>di.locator<PopularMovieBloc>()),
        BlocProvider(create: (_)=>di.locator<WatchlistMovieBloc>()),
        BlocProvider(create: (_)=>di.locator<SearchMovieBloc>()),

        // Series
        BlocProvider(create: (_)=>di.locator<seriesPopularBloc>()),
        BlocProvider(create: (_)=>di.locator<TopratedSeriesBloc>()),
        BlocProvider(create: (_)=>di.locator<SeriesTodayBloc>()),
        BlocProvider(create: (_)=>di.locator<SeriesOnAirBloc>()),
        BlocProvider(create: (_)=>di.locator<WatchlistSeriesBloc>()),
        BlocProvider(create: (_)=>di.locator<RecommendationTvseriesBloc>()),
        BlocProvider(create: (_)=>di.locator<SeriesDetailBloc>()),
        BlocProvider(create: (_)=>di.locator<SearchSeriesBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
            primaryColor: Colors.transparent,
            scaffoldBackgroundColor: const Color.fromARGB(255, 1, 3, 66),
        ),
        home: HomeMoviePage(),
        debugShowCheckedModeBanner: false,
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.initial_route:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case MoviePopularPage.initial_route:
              return CupertinoPageRoute(builder: (_) => MoviePopularPage());
            case TopRatedMoviesPage.initial_route:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.initial_route:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case MovieSearchPage.initial_route:
              return CupertinoPageRoute(builder: (_) => MovieSearchPage());
            case MovieWatchlist_Page.initial_route:
              return MaterialPageRoute(builder: (_) => MovieWatchlist_Page());
            case AboutPage.initial_route:
              return MaterialPageRoute(builder: (_) => AboutPage());
            
            case SeriesDetailPage.initial_route:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => SeriesDetailPage(id: id), settings: settings);
            case SeriesOnTheAirPage.initial_route:
              return MaterialPageRoute(builder: (_) => SeriesOnTheAirPage());
            case AiringTodayPage.initial_route:
              return MaterialPageRoute(builder: (_) => AiringTodayPage());
            case PopularSeriesPage.initial_route:
              return MaterialPageRoute(builder: (_) => PopularSeriesPage());
            case TopRatedSeriesPage.initial_route:
              return CupertinoPageRoute(builder: (_) => TopRatedSeriesPage());
            case SearchSeriesPage.initial_route:
              return MaterialPageRoute(builder: (_) => SearchSeriesPage());
            case WatchListSeriesPage.initial_route:
              return MaterialPageRoute(builder: (_) => WatchListSeriesPage());
            case SeriesPage.initial_route:
              return MaterialPageRoute(builder: (_) => SeriesPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
