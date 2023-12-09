import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:machine_test/app/models/movie_model.dart';
import 'package:machine_test/utils/api_const.dart';

class SearchMovieController extends GetxController {
  final searchResults = <Result>[].obs;
  final searchTextField = TextEditingController();
  final baseUrl = 'https://api.themoviedb.org/3/search/movie';
  String currentQuery = '';
  final isLoading = false.obs;

  Future<void> searchMovies(String query, {int page = 1}) async {
    isLoading(true); // Set loading to true when fetching data

    if (currentQuery != query) {
      searchResults.clear();
      currentQuery = query;
    }

    final url = '$baseUrl?api_key=$apiKey&query=$query&page=$page';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['results'];

        searchResults.addAll(results
            .map((result) => Result.fromJson(result))
            .where((result) => result.posterPath.isNotEmpty));

        isLoading(false); // Set loading to false when data is loaded
        update();
      } else {
        isLoading(false); // Set loading to false on error
        Get.snackbar('Error', 'Failed to load search results');
      }
    } catch (e) {
      isLoading(false); // Set loading to false on error
      Get.snackbar('Keep Patient', 'Results are Loading...wait');
    }
  }
}
