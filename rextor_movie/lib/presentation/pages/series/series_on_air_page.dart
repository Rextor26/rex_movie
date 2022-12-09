import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rextor/presentation/bloc/series/series_even.dart';
import 'package:rextor/presentation/bloc/series/series_bloc.dart';
import 'package:rextor/presentation/bloc/series/series_state_management.dart';
import 'package:rextor/presentation/widgets/series_card.dart';
import 'package:flutter/material.dart';

class SeriesOnTheAirPage extends StatefulWidget {
  static const initial_route = '/on-the-air';
  const SeriesOnTheAirPage({Key? key}) : super(key: key);
  @override
  _SeriesOnTheAirPageState createState() => _SeriesOnTheAirPageState();
}

class _SeriesOnTheAirPageState extends State<SeriesOnTheAirPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
    context.read<SeriesOnAirBloc>().add(const FetchTvseriesData()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 3, 71),
        title: const Text('Series Series On The Air'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<SeriesOnAirBloc, SeriesStateManagement>(
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
        ),
      ),
    );
  }
}
