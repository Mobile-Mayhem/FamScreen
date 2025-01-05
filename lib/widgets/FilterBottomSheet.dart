import '../utils/Colors.dart';
import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  final String selectedGenre;
  final Function(String) onGenreSelected;

  const FilterBottomSheet({
    Key? key,
    required this.selectedGenre,
    required this.onGenreSelected,
  }) : super(key: key);

  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late String _selectedGenre;

  @override
  void initState() {
    super.initState();
    _selectedGenre = widget.selectedGenre;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 4,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: 210.0), // Padding added to align with the buttons
            child: const Text(
              "Filter Genre",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          FilterRow(
            selectedGenre: _selectedGenre,
            onGenreSelected: (genre) {
              setState(() {
                _selectedGenre = genre;
              });
              widget.onGenreSelected(genre);
            },
          ),
        ],
      ),
    );
  }
}

class FilterRow extends StatelessWidget {
  final String selectedGenre;
  final Function(String) onGenreSelected;

  const FilterRow({
    Key? key,
    required this.selectedGenre,
    required this.onGenreSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> genres = [
      {'text': 'Semua', 'value': 'semua'},
      {'text': 'Aksi', 'value': 'aksi'},
      {'text': 'Animasi', 'value': 'animasi'},
      {'text': 'Drama', 'value': 'drama'},
      {'text': 'Fantasi', 'value': 'fantasi'},
      {'text': 'Horor', 'value': 'horor'},
      {'text': 'Komedi', 'value': 'komedi'},
      {'text': 'Misteri', 'value': 'misteri'},
      {'text': 'Petualangan', 'value': 'petualangan'},
      {'text': 'Psikologi', 'value': 'psikologi'},
    ];

    return Wrap(
      spacing: 5.0, // button
      runSpacing: 3.0, // line
      children: genres.map((genre) {
        return FilterGenre(
          text: genre['text']!,
          isSelected: selectedGenre == genre['value'],
          onPressed: () {
            print("Genre selected: ${genre['value']!}");
            onGenreSelected(genre['value']!);
          },
        );
      }).toList(),
    );
  }
}

class FilterGenre extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const FilterGenre({
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
