
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test/app/controller/main_controller.dart';
import 'package:machine_test/app/models/movie_model.dart';
import 'package:machine_test/app/views/details/details_screen.dart';
import 'package:machine_test/utils/api_const.dart';
import 'package:machine_test/utils/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MovieController());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder(
          future: controller.popularmovies,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  MovieDataModel? data = snapshot.data as MovieDataModel?;
                  List<Result> results = data?.results ?? [];
                  String poster = results[index].backdropPath;
                  String title = results[index].title;
                  String descr = results[index].overview;
                  String rating = results[index].voteAverage.toString();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => DetailsScreen(movie: results[index]));
                      },
                      child: Card(
                        color: Colours.kDarkBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 9,
                        child: SizedBox(
                          height: 250,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: double.infinity,
                                width: 150,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: '$imagePath$poster',
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(), // Placeholder widget while loading
                                    errorWidget: (context, url, error) => const Icon(Icons
                                        .error), // Widget to show in case of an error
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(title),
                                      Text(
                                        descr,
                                        maxLines: 7,
                                      ),
                                      Text("⭐ $rating"),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
