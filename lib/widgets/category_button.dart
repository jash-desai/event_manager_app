import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';

import '../globals/myColors.dart';
import '../globals/sizeConfig.dart';

class CategoryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: AnimatedButton(
        width: SizeConfig.horizontalBlockSize * 15,
        child: Text(
          'W',
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        color: matteBlackLite,
        onPressed: () {},
        enabled: true,
        shadowDegree: ShadowDegree.light,
      ),
    );
  }
}
