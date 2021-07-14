import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../globals/myColors.dart';
import '../globals/myFonts.dart';
import '../globals/mySpaces.dart';
import '../globals/sizeConfig.dart';
import '../providers/authentication.dart';
import '../screens/login.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  // Initializing Variables
  File _imageFile;
  final _auth = FirebaseAuth.instance;
  var isLoading = false;
  final picker = ImagePicker();

  // Did this to get the break the name into different lines
  final String name =
      FirebaseAuth.instance.currentUser.displayName.replaceAll(" ", "\n");

  // fucntion to set the user profile picture

  Future pickImage() async {
    // Open gallery to select the image
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    // run the build method again to show a loading spinner at the place of this widget
    setState(() {
      _imageFile = File(pickedFile.path);
      isLoading = true;
    });

    // Upload the image to firebase storage with the name as UserId
    final firebaseStorageRef =
        FirebaseStorage.instance.ref().child('images/${_auth.currentUser.uid}');
    final uploadTask = firebaseStorageRef.putFile(_imageFile);

    // the response that firebase returns us in uploadTask is the URL of the image which we can show in our app
    uploadTask.then((taskSnapshot) {
      taskSnapshot.ref.getDownloadURL().then((value) async {
        try {
          await _auth.currentUser.updatePhotoURL(value);
        } catch (error) {
          print(error);
        }
        // Stop the loading once fetching and setting it done
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: drawerbackground,
        padding: EdgeInsets.symmetric(
            vertical: SizeConfig.verticalBlockSize * 7,
            horizontal: SizeConfig.horizontalBlockSize * 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: pickImage,
              child: isLoading
                  ? CircularProgressIndicator() //Show a loading spinner while uploading the image
                  : CircleAvatar(
                      radius: SizeConfig.horizontalBlockSize * 11,
                      backgroundImage: NetworkImage(
                        FirebaseAuth.instance.currentUser.photoURL ??
                            "https://i.pinimg.com/564x/d7/22/d9/d722d9b3f8f8ae58d2fd3b4cb9dd657c.jpg",
                      ),
                      // ?? syntax is used to check if a particular value is null and if it is null then do something else
                      // In this case if there is no photoUrl then a default image would be shown to the user
                    ),
            ),
            MySpaces.vLargeGapInBetween,
            Text(
              name,
              style: MyFonts.bold
                  .setColor(kWhite)
                  .letterSpace(3)
                  .size(SizeConfig.horizontalBlockSize * 7),
            ),
            MySpaces.vLargestGapInBetween,
            ...List.generate(4, (index) => "Option $index").map((e) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: kGrey,
                    ),
                    MySpaces.hSmallestGapInBetween,
                    Text(
                      e,
                      style: MyFonts.medium
                          .setColor(kWhite)
                          .size(SizeConfig.horizontalBlockSize * 5),
                    ),
                  ],
                ),
              );
            }).toList(),
            Spacer(),
            Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Settings',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 2,
                  height: 20,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    final authInstance =
                        Provider.of<Authentication>(context, listen: false);
                    authInstance.signOut().then((value) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Login.routeName, (route) => true);
                    }).catchError((error) {
                      authInstance.showError(error.toString(), context);
                    });
                  },
                  child: Text(
                    'Log out',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
