import 'package:flutter/material.dart';

import '../utils/Colors.dart';

class ShapePutihDetail extends StatelessWidget {
  const ShapePutihDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(screenHeight * 0.02),
      margin: EdgeInsets.only(top: screenHeight * 0.25),
      decoration: const BoxDecoration(
        color: CustomColor.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
  }
}
