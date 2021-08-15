import 'package:event_manager/globals/myColors.dart';
import 'package:event_manager/globals/myFonts.dart';
import 'package:event_manager/globals/mySpaces.dart';
import 'package:event_manager/globals/sizeConfig.dart';
import 'package:event_manager/models/task.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../functions/func.dart' as func;

class TaskWidget extends StatelessWidget {
  final Task task;

  TaskWidget(this.task);

  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 2.5),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: kGrey, width: 0.3),
          borderRadius: BorderRadius.circular(13),
        ),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.only(right: 8, top: 8, left: 10, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "${task.title}",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: MyFonts.bold.size(18),
                ),
              ),
              MySpaces.vSmallGapInBetween,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    child: Text(
                      DateFormat("d MMMM yy").format(task.date),
                      overflow: TextOverflow.ellipsis,
                      style: MyFonts.medium
                          .setColor(kGrey)
                          .size(SizeConfig.horizontalBlockSize * 3),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: Text(
                      "${func.hours(task.startTime)}:${func.minutes(task.startTime)}${func.timeMode(task.startTime)} - ${func.hours(task.endTime)}:${func.minutes(task.endTime)}${func.timeMode(task.endTime)}",
                      overflow: TextOverflow.ellipsis,
                      style: MyFonts.medium
                          .setColor(kGrey)
                          .size(SizeConfig.horizontalBlockSize * 3),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
    // return Container(
    //   height: 100,
    //   width: 100,
    //   child: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Text(
    //           task.title,
    //           style: TextStyle(
    //             fontSize: 18,
    //             fontWeight: FontWeight.w900,
    //           ),
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Text(
    //                 DateFormat("d MMMM yyyy").format(task.date),
    //                 style: TextStyle(
    //                   fontSize: 14,
    //                   color: Colors.grey.shade600,
    //                   fontWeight: FontWeight.w900,
    //                 ),
    //               ),
    //             ),
    //             Text(
    //               "${func.hours(task.startTime)}:${func.minutes(task.startTime)}${func.timeMode(task.startTime)} - ${func.hours(task.endTime)}:${func.minutes(task.endTime)}${func.timeMode(task.endTime)}",
    //               style: TextStyle(
    //                 fontSize: 14,
    //                 color: Colors.grey.shade400,
    //                 fontWeight: FontWeight.w900,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    //   decoration: BoxDecoration(
    //     border: Border.all(color: Colors.grey),
    //     borderRadius: BorderRadius.circular(10),
    //     shape: BoxShape.rectangle,
    //   ),
    // );
  }
}
