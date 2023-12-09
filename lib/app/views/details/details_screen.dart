
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:machine_test/app/controller/main_controller.dart';
import 'package:machine_test/app/models/movie_model.dart';
import 'package:machine_test/app/utils/api_const.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({Key? key, required this.movie}) : super(key: key);

  final MovieController movieController = Get.put(MovieController());
  final Result movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("Details"),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 250,
                          width: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              child: (movie.posterPath.isNotEmpty)
                                  ? Image.network(
                                      '$imagePath${movie.posterPath}',
                                      fit: BoxFit.cover,
                                    )
                                  : const Center(
                                      child: Text("No Image Available"),
                                    ),
                            ),
                          ),
                        ),
                        Container(
                          height: 250,
                          width: 180,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                movie.overview,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 9,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width * 0.4,
                         
                          child: Column(
                            children: [
                                SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Released on",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                DateFormat('yyyy-MM-dd').format(movie.releaseDate),
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width * 0.4,
                          
                           child: Column(
                            children: [
                                SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Rating",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                movie.voteAverage.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: (movie.backdropPath.isNotEmpty)
                          ? SizedBox(
                              height: 200,
                              child: Image.network(
                                  "$imagePath${movie.backdropPath}"),
                            )
                          : const Center(
                              child: Text("No Image Available"),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
