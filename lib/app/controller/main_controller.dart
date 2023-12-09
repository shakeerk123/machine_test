// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:machine_test/app/api/api_services.dart';
import 'package:machine_test/app/models/movie_model.dart';

class MovieController extends GetxController {
  ApiClient apiClient = ApiClient();
  TextEditingController searchTextField = TextEditingController();
  List<Result> favoriteMovies = [];


  var currentIndex = 0.obs;
  var popularmovies;
  var topratedmovies;
  var upComingmovies;
  var nowPlayingmovies;
  var malayalamMovies;
  var animationMovies;
  var tamilMovie;
  var searchMovie;
  var hindiMovie;
  var getMovieCast;




  @override
  void onInit() {
    hindiMovie =apiClient.getHindiMovies();
    tamilMovie =apiClient. getTamilMovie();
    malayalamMovies =apiClient. getMalayalamMovies();
    popularmovies =apiClient.getPopularMovies();
    topratedmovies =apiClient. getTopRatedMovies();
    upComingmovies =apiClient. getUpcomingMovies();
    nowPlayingmovies =apiClient. getNowPlayingMovies();
    animationMovies =apiClient. getAnimationMovies();
    
    super.onInit();
  }

  void onTap(int index) {
    currentIndex.value = index;
  }
 
}