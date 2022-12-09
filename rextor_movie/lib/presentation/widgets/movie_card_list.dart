import 'package:cached_network_image/cached_network_image.dart';
import 'package:rextor/domain/entities/movie/movie.dart';
import 'package:rextor/presentation/pages/movie/movie_detail_page.dart';
import 'package:flutter/material.dart';
const String BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/w500';
class MovieCard extends StatelessWidget {
  final Movie movie;

  MovieCard(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            MovieDetailPage.initial_route,
            arguments: movie.id,
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
                          movie.title ?? '-',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                   
                      Text(
                        movie.overview ?? '-',
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
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  width: 80,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            
          ],
        ),
      ),
    );
  }
}
