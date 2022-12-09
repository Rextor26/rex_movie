import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rextor/common/state_enum.dart';
import 'package:rextor/presentation/bloc/series/series_even.dart';
import 'package:rextor/presentation/bloc/series/series_bloc.dart';
import 'package:rextor/presentation/bloc/series/series_watchlist_notifier.dart';
import 'package:rextor/presentation/widgets/series_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../bloc/series/series_state_management.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
class WatchListSeriesPage extends StatefulWidget {
  static const initial_route = '/watchlistPage_Series';
  const WatchListSeriesPage({Key? key}) : super(key: key);

  @override
  State<WatchListSeriesPage> createState() => _WatchListSeriesPageState();
}

class _WatchListSeriesPageState extends State<WatchListSeriesPage> with RouteAware {


  @override
  void initState() {
    super.initState();
    Future.microtask(() => 
    context.read<WatchlistSeriesBloc>().add(const FetchTvseriesData()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    super.didPopNext();
   context.read<WatchlistSeriesBloc>().add(const FetchTvseriesData());
  }

  @override
  void dispose() {
    super.dispose();
    routeObserver.unsubscribe(this);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 3, 71),
        title: Text('Watchlist Series'),
    ),
    
    body: Padding(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<WatchlistSeriesBloc, SeriesStateManagement>(
          builder: (context, state) {
            if (state is LoadingDataSeries) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedDataSeries) {
              final result = state.result;
              print('Berhasil');
              return ListView.builder(
                  itemCount: result.length,
                  itemBuilder: (context, index) {
                    final series = result[index];
                    return SeriesCard(series);
                  },
                  
                  );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text('')
              );
            }
          },
      ),)
    );
  }
}
