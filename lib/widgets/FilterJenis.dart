import 'package:flutter/material.dart';
import '../utils/Colors.dart';

class FilterJenis extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const FilterJenis({
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

class FilterRow extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const FilterRow({
    Key? key,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FilterJenis(
          text: 'All',
          isSelected: selectedCategory == 'All',
          onPressed: () {
            onCategorySelected('All');
          },
        ),
        FilterJenis(
          text: 'Movies',
          isSelected: selectedCategory == 'Movies',
          onPressed: () {
            onCategorySelected('Movies');
          },
        ),
        FilterJenis(
          text: 'Series',
          isSelected: selectedCategory == 'Series',
          onPressed: () {
            onCategorySelected('Series');
          },
        ),
      ],
    );
  }
}