import 'package:flutter/material.dart';
import 'package:projek/utils/Colors.dart';
import 'package:projek/data/models/film.dart';

class CategoryButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const CategoryButton({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? CustomColor.primary : Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: isSelected ? Colors.transparent : Colors.grey[300]!,
              width: 1.5,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

class CategoryRow extends StatelessWidget {
  final List<Film> allFilms;
  final String selectedCategory;
  final Function(String) onCategorySelected;
  final Function(List<Film>) onFilteredFilms; // Callback untuk mengirim daftar film yang difilter

  const CategoryRow({
    Key? key,
    required this.allFilms,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.onFilteredFilms,
  }) : super(key: key);

  void filterFilms(String jenis) {
    List<Film> filteredFilms;
    if (jenis == 'All') {
      filteredFilms = allFilms;
    } else {
      filteredFilms = allFilms.where((film) => film.jenis == jenis).toList();
    }
    onFilteredFilms(filteredFilms);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CategoryButton(
          text: 'All',
          isSelected: selectedCategory == 'All',
          onPressed: () {
            onCategorySelected('All');
            filterFilms('All');
          },
        ),
        CategoryButton(
          text: 'Movies',
          isSelected: selectedCategory == 'Movies',
          onPressed: () {
            onCategorySelected('Movies');
            filterFilms('film');
          },
        ),
        CategoryButton(
          text: 'Series',
          isSelected: selectedCategory == 'Series',
          onPressed: () {
            onCategorySelected('Series');
            filterFilms('series');
          },
        ),
      ],
    );
  }
}