import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rextor/presentation/bloc/series/series_search_bloc.dart';
import 'package:rextor/presentation/bloc/series/series_search_event.dart';
import 'package:rextor/presentation/bloc/series/series_search_state_management.dart';
import 'package:rextor/presentation/widgets/series_card.dart';
import 'package:flutter/material.dart';
class SearchSeriesPage extends StatelessWidget {
  static const initial_route = '/SearchPage_Series';
  const SearchSeriesPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 0, 3, 71),
        title: const Text("Search Series"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<SearchSeriesBloc>().add(OnQueryChangedSeries(query));
              },
              
              decoration: const InputDecoration(
                hintText: 'Search Series',
                prefixIcon: Icon(Icons.search_outlined),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Search Result',
            ),
             BlocBuilder<SearchSeriesBloc, SearchStateSeries>(
              builder: (context, state) {
                if (state is SearchLoadingSeries) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchHasDataSeries) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final series = result[index];
                        return SeriesCard(series);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (state is SearchErrorSeries) {
                  return Expanded(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return const Expanded(
                    child: Center(
                      child: Text("Data tidak ditemukan"),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
