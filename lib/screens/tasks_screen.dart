import 'package:event_manager/globals/myFonts.dart';
import 'package:event_manager/globals/mySpaces.dart';
import 'package:event_manager/models/group.dart';
import 'package:event_manager/providers/tasks.dart';
import 'package:event_manager/screens/create_new_task.dart';
import 'package:event_manager/screens/edit_category_screen.dart';
import 'package:event_manager/widgets/category_button.dart';
import 'package:event_manager/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../globals/myColors.dart';
import '../globals/sizeConfig.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  double topPadding = 0;

  bool isDrawerOpen = false;

  // final _auth = FirebaseAuth.instance;

  final Group allTasksCat = Group(
    icon: Icons.today,
    color: kWhite,
  );
  Group currentCat;
  @override
  void initState() {
    super.initState();
    currentCat = allTasksCat;
  }

  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<Tasks>(context);
    return Expanded(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            // color: kBlue,
            width: SizeConfig.horizontalBlockSize * 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Text(
                        "TASKS LIST",
                        style: MyFonts.medium
                            .setColor(kGrey)
                            .size(SizeConfig.horizontalBlockSize * 4),
                      ),
                      MySpaces.vSmallestGapInBetween,
                      Text(
                        currentCat.title ?? "All Task",
                        style: MyFonts.bold
                            .size(SizeConfig.horizontalBlockSize * 9),
                      ),
                      MySpaces.vGapInBetween,
                      if (currentCat == allTasksCat)
                        ...taskData.todaysTask.map((task) {
                          return TaskWidget(task);
                        }).toList(),
                      if (currentCat != allTasksCat)
                        ...taskData.availableTasks(currentCat).map((task) {
                          return TaskWidget(task);
                        }).toList(),
                    ],
                  ),
                ),
                // Expanded(
                //   child: ListView.builder(
                //     itemBuilder: (ctx, index) {
                //       return TaskWidget(taskData.tasks[index]);
                //     },
                //     itemCount: taskData.tasks.length,
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(CreateNewTask.routeName),
                    child: Text(
                      "+ ADD NEW TASK",
                      style: MyFonts.medium
                          .size(SizeConfig.horizontalBlockSize * 5),
                    ),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      primary: kWhite,
                      backgroundColor: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: SizeConfig.horizontalBlockSize * 20,
            color: matteBlack,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MySpaces.vGapInBetween,
                CategoryButton(
                    Group(
                      icon: Icons.today,
                      color: kWhite,
                    ), () {
                  setState(() {
                    currentCat = allTasksCat;
                  });
                }),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      return CategoryButton(taskData.categories[index], () {
                        setState(() {
                          currentCat = taskData.categories[index];
                        });
                      });
                    },
                    itemCount: taskData.categories.length,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(EditCategoryScreen.routeName),
                  icon: Icon(
                    Icons.add,
                    color: kGrey,
                    size: SizeConfig.verticalBlockSize * 5,
                  ),
                ),
                MySpaces.vSmallGapInBetween,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
