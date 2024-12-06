import 'package:flutter/material.dart';

import '../utils/Colors.dart';

class ShapePutihDetail extends StatelessWidget {
  const ShapePutihDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(top: 195),
      decoration: const BoxDecoration(
        color: CustomColor.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(9),
          topRight: Radius.circular(9),
        ),
      ),
    );
  }
}
