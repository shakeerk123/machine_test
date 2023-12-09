
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine_test/app/controller/search_controller.dart';
import 'package:machine_test/app/models/movie_model.dart';
import 'package:machine_test/app/views/details/details_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class SearchGridViewWidget extends StatelessWidget {
  const SearchGridViewWidget({
    super.key,
    required this.controller,
    required this.searchResults,
  });

  final SearchMovieController controller;
  final RxList<Result> searchResults;

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (onScrollNotification) {
        if (onScrollNotification is ScrollEndNotification) {
          final before = onScrollNotification.metrics.extentBefore;
          final max = onScrollNotification.metrics.maxScrollExtent;

          if (before == max) {
            final query = controller.currentQuery;
            final nextPage = searchResults.length ~/ 20 + 1;
            
            if (nextPage == 1) {
              searchResults.clear();
            }
            controller.searchMovies(query, page: nextPage);
            return true;
          }
          return false;
        }
        return false;
      },
      child: GridView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final Result movie = searchResults[index];
          final posterPath = movie.posterPath;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(movie: movie),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: posterPath.isNotEmpty
                                ? FadeInImage.memoryNetwork(
                                    image: "https://image.tmdb.org/t/p/w185$posterPath",
                                    placeholder: kTransparentImage,
                                    fit: BoxFit.cover,
                                  )
                                : const Center(
                                    child: Text('Image not available'),
                                  ),
                          ),
                          Text(
                            movie.title,
                            maxLines: 1,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '🌟${movie.voteAverage.toStringAsFixed(1)} / 10',
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 5,
          mainAxisExtent: 264,
        ),
      ),
    );
  }
}
