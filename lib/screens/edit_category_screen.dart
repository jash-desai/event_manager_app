import 'package:event_manager/globals/myColors.dart';
import 'package:event_manager/globals/mySpaces.dart';
import 'package:event_manager/models/group.dart';
import 'package:event_manager/providers/database_helper.dart';
import 'package:event_manager/providers/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';

class EditCategoryScreen extends StatefulWidget {
  static const routeName = 'edit-category-screen';

  @override
  _EditCategoryScreenState createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  var isLoading = false;
  final _formKey = GlobalKey<FormState>();

  String _title;
  Color _color;

  submit() async {
    _formKey.currentState.save();

    setState(() {
      isLoading = true;
    });
    try {
      var cat = Group(
        title: _title,
        color: _color,
      );

      final id = await DatabaseHelper.instance.insertCategory(cat.toMap());
      print(id);

      Provider.of<Tasks>(context, listen: false).addCategory(cat.addId(id));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Category added successfully")));
    } catch (error) {
      print(error);
    }

    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: matteBlack,
        title: Text("Add Category"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Title",
                        icon: Icon(Icons.edit),
                        // labelStyle:
                      ),
                      onSaved: (value) {
                        _title = value;
                      },
                    ),
                  ),
                  MySpaces.vLargeGapInBetween,
                  Spacer(),
                  Text("Select Color"),
                  MySpaces.vGapInBetween,
                  Expanded(
                    child: MaterialColorPicker(
                      onColorChange: (Color color) {
                        _color = color;
                      },
                      selectedColor: _color,
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      enableFeedback: true,
                      backgroundColor: MaterialStateProperty.all(matteBlack),
                    ),
                    onPressed: submit,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
