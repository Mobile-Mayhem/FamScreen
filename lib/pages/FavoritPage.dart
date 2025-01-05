import 'package:famscreen/routes/AppRoutes.dart';
import 'package:famscreen/widgets/SearchBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/FavoriteController.dart';
import '../widgets/FavItem.dart';
import 'DetailPage.dart';

class FavoritePage extends StatelessWidget {
  final FavoriteController controller = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Favorit',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SearchInput(
              onChanged: (query) {
                controller.favoriteMovies.value = controller.favoriteMovies
                    .where((movie) => movie['judul']
                        .toString()
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                    .toList();
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.favoriteMovies.isEmpty
                        ? Center(
                            child: Text('Belum ada film favorit.'),
                          )
                        : GridView.builder(
                            padding: EdgeInsets.all(3),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.6,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 5,
                            ),
                            itemCount: controller.favoriteMovies.length,
                            itemBuilder: (context, index) {
                              var movie = controller.favoriteMovies[index];
                              return FavoriteItem(
                                title: movie['judul'],
                                image: movie['poster_potrait'] ??
                                    'assets/placeholder.jpg',
                                onRemove: () =>
                                    controller.removeFavorite(movie['judul']),
                                onTap: () {
                                  Get.toNamed(AppRoutes.detailPage,
                                      arguments: {'movie': movie});
                                },
                              );
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
