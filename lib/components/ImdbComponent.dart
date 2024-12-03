import 'package:flutter/widgets.dart';

class ImdbComponent extends StatelessWidget {
  const ImdbComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color(0xffF5C518),
      ),
      child: const Text('IMDb',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}
