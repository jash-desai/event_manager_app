import 'package:event_manager/globals/myFonts.dart';
import 'package:event_manager/models/group.dart';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';

import '../globals/myColors.dart';
import '../globals/sizeConfig.dart';

class CategoryButton extends StatelessWidget {
  final Group grp;
  final Function function;

  const CategoryButton(this.grp, this.function);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.horizontalBlockSize * 2.5),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: AnimatedButton(
        width: SizeConfig.horizontalBlockSize * 15,
        child: (grp.icon != null)
            ? Icon(
                grp.icon,
                color: grp.color,
              )
            : Text(
                grp.title.toUpperCase().substring(0, 1),
                style: MyFonts.bold.setColor(grp.color).size(30),
              ),
        color: matteBlackLite,
        onPressed: function,
        enabled: true,
        shadowDegree: ShadowDegree.light,
      ),
    );
  }
}
