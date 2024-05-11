import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Colours {
  static const scaffoldBGColor = Color.fromARGB(255, 0, 0, 0);
  static const ratingColor = Color(0xFFFFC107);
}

class BackBtn extends StatelessWidget {
  const BackBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      margin: const EdgeInsets.only(top: 16, left: 16),
      decoration: BoxDecoration(
          color: Colours.scaffoldBGColor,
          borderRadius: BorderRadius.circular(8)),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_rounded),
      ),
    );
  }
}
