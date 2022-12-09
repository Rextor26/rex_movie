import 'package:cached_network_image/cached_network_image.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/presentation/pages/series/series_detail_page.dart';
import 'package:flutter/material.dart';

const String BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/w500';
class SeriesCard extends StatelessWidget {
  final Series series;
  const SeriesCard(this.series, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            SeriesDetailPage.initial_route,
            arguments: series.id,
          );
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            SizedBox(
               height: 122,
              width: 365,
              child: Card(
                color: const Color.fromARGB(255, 2, 6, 112),
                child: Container(
                  margin: const EdgeInsets.only(
                       left: 85, bottom: 8, right: 8, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          series.name ?? '-',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                   
                      Text(
                        series.overview ?? '-',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
           ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${series.posterPath}',
                  width: 80,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
          ]
      )
      )
    );
  }
}
