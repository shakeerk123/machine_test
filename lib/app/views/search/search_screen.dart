import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test/widgets/search_widgets/search_grid.dart';
import '../../controller/search_controller.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final SearchMovieController controller = Get.put(SearchMovieController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9),
                      child: TextField(
                        controller: controller.searchTextField,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  String query =
                                      controller.searchTextField.text;
                                  controller.searchMovies(query);
                                },
                                icon: const Icon(Icons.send),
                                color: Colors.white70),
                            border: InputBorder.none,
                            hintText: 'Search for movies'),
                      )))),
          Expanded(
            child: Obx(() {
              final searchResults = controller.searchResults;
              if (searchResults.isEmpty) {
                return const Center(child: Text('No search results found'));
              }
              return SearchGridViewWidget(
                  controller: controller, searchResults: searchResults);
            }),
          ),
        ],
      ),
    );
  }
}
