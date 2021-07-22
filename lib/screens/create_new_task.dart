import 'package:event_manager/globals/myColors.dart';
import 'package:event_manager/globals/myFonts.dart';
import 'package:event_manager/globals/mySpaces.dart';
import 'package:event_manager/globals/sizeConfig.dart';
import 'package:event_manager/models/group.dart';
import 'package:event_manager/models/task.dart';
import 'package:event_manager/providers/database_helper.dart';
import 'package:event_manager/providers/tasks.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:time_range_picker/time_range_picker.dart';
import '../functions/func.dart' as func;

class CreateNewTask extends StatefulWidget {
  static const routeName = 'create-new-task';
  @override
  _CreateNewTaskState createState() => _CreateNewTaskState();
}

class _CreateNewTaskState extends State<CreateNewTask> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime, _endTime;
  String _taskName;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Group _value;

  Future<void> _selectDate() async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate)
      setState(() {
        _selectedDate = pickedDate;
      });
  }

  void _selectTime() async {
    TimeRange result = await showTimeRangePicker(
      use24HourFormat: false,
      backgroundWidget: Image.asset(
        "assets/images/clock.png",
        height: 200,
        width: 200,
      ),
      strokeWidth: 4,
      ticks: 24,
      ticksOffset: -7,
      ticksLength: 15,
      ticksColor: Colors.grey,
      labels: ["12 am", "3 am", "6 am", "9 am", "12 pm", "3 pm", "6 pm", "9 pm"]
          .asMap()
          .entries
          .map((e) {
        return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
      }).toList(),
      context: context,
    );
    setState(() {
      _endTime = result.endTime;
      _startTime = result.startTime;
    });
  }

  void saveForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      isLoading = true;
    });

    try {
      var task = Task(
        title: _taskName,
        date: _selectedDate,
        startTime: _startTime,
        endTime: _endTime,
        category: _value,
      );

      final id = await DatabaseHelper.instance.insert(task.toMap());
      print(id);

      Provider.of<Tasks>(context, listen: false).addTask(task.addId(id));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Task added successfully")));
    } catch (error) {
      print(error);
    }

    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop();
  }

  bool isToggle = true;
  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<Tasks>(context, listen: false);
    return Material(
      child: SafeArea(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          padding: EdgeInsets.all(0),
                          alignment: Alignment.centerLeft,
                          iconSize: SizeConfig.horizontalBlockSize * 7,
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(Icons.arrow_back),
                        ),
                        MySpaces.vGapInBetween,
                        Text(
                          'Create \nNew Task',
                          textAlign: TextAlign.start,
                          style: MyFonts.extraBold.size(
                            SizeConfig.horizontalBlockSize * 10,
                          ),
                        ),
                        MySpaces.vGapInBetween,
                        TextFormField(
                          cursorHeight: 28,
                          cursorColor: Colors.grey[400],
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 20.0,
                          ),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.grey[600]),
                            hintStyle: TextStyle(color: Colors.grey),
                            focusColor: Colors.grey[800],
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade800,
                              ),
                            ),
                            hintText: 'Task Name',
                          ),
                          onSaved: (value) {
                            _taskName = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Task name cannot be Empty";
                            }
                            return null;
                          },
                        ),
                        MySpaces.vSmallGapInBetween,
                        InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: _selectDate,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.amber.shade100,
                                    border: Border.all(
                                      color: Colors.amber.shade100,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Icon(
                                    Icons.calendar_today_rounded,
                                    color: Colors.amber.shade800,
                                  ),
                                ),
                                MySpaces.hMediumGapInBetween,
                                Text(
                                  DateFormat("EEEE d, MMMM")
                                      .format(_selectedDate),
                                  style: MyFonts.bold
                                      .size(SizeConfig.horizontalBlockSize * 5)
                                      .setColor(kGrey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        MySpaces.vGapInBetween,
                        InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: _selectTime,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade50,
                                    border: Border.all(
                                      color: Colors.orange.shade100,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Icon(
                                    Icons.access_time_rounded,
                                    color: Colors.amber.shade800,
                                  ),
                                ),
                                MySpaces.hMediumGapInBetween,
                                Text(
                                  (_startTime == null && _endTime == null)
                                      ? "Select Time Range"
                                      : "${func.hours(_startTime)} : ${func.minutes(_startTime)} ${func.timeMode(_startTime)} - ${func.hours(_endTime)} : ${func.minutes(_endTime)} ${func.timeMode(_endTime)}",
                                  style: MyFonts.bold
                                      .size(SizeConfig.horizontalBlockSize * 5)
                                      .setColor(kGrey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        MySpaces.vMediumGapInBetween,
                        Container(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.purple.shade50,
                                    border: Border.all(
                                      color: Colors.purple.shade100,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Icon(
                                    Icons.category,
                                    color: Colors.purple.shade400,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15.0,
                                    horizontal: 20,
                                  ),
                                  child: DropdownButton<Group>(
                                    hint: Text(
                                      "Select a category",
                                      style: MyFonts.medium.size(17),
                                    ),
                                    // isExpanded: true,

                                    items:
                                        taskData.categories.map((Group item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item.title,
                                          style: MyFonts.medium.size(
                                              SizeConfig.horizontalBlockSize *
                                                  5),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _value = value;
                                      });
                                    },
                                    value: _value,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                        MySpaces.vMediumGapInBetween,
                        Container(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade50,
                                        border: Border.all(
                                          color: Colors.blue.shade100,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                            Icons.notifications_none_outlined),
                                        onPressed: () {},
                                        color: Colors.blue.shade400,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        "Remind Me",
                                        style: MyFonts.medium.size(18),
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isToggle = !isToggle;
                                    });
                                  },
                                  icon: isToggle == false
                                      ? Icon(
                                          Icons.toggle_on,
                                          color: Colors.blue,
                                        )
                                      : Icon(Icons.toggle_off),
                                  iconSize: 60,
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                        MySpaces.vMediumGapInBetween,
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: saveForm,
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              padding: EdgeInsets.symmetric(
                                horizontal: 115,
                                vertical: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              'CREATE TASK',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
