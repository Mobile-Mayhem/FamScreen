import 'package:famscreen/pages/HomePage.dart';
import 'package:flutter/material.dart';

class AppBarDetail extends StatefulWidget {
  final Future<bool> isFavoriteFuture;
  final Function toggleFavorite;

  const AppBarDetail({
    Key? key,
    required this.isFavoriteFuture,
    required this.toggleFavorite,
  }) : super(key: key);

  @override
  _AppBarDetailState createState() => _AppBarDetailState();
}

class _AppBarDetailState extends State<AppBarDetail> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _initializeFavoriteStatus();
  }

  Future<void> _initializeFavoriteStatus() async {
    isFavorite = await widget.isFavoriteFuture;
    setState(() {});
  }

  void _onToggleFavorite() async {
    setState(() {
      isFavorite = !isFavorite;
    });

    await widget.toggleFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      actions: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: _onToggleFavorite,
          ),
        ),
      ],
    );
  }
}
