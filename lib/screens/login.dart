import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';

import '../globals/myFonts.dart';
import '../providers/authentication.dart';
import '../screens/homepage.dart';
import '../screens/signup.dart';
import '../widgets/auth_screen_intro.dart';
import '../globals/sizeConfig.dart';
import '../globals/myColors.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Initializing Fields
  final _formKey = GlobalKey<FormState>();
  String _email, _password;
  var isLoading = false;

  // method to log the user in and navigate to homescreen
  // also to show a dialog box in case of error
  void tryLogIn() async {
    if (!_formKey.currentState.validate()) {
      return null;
    }
    _formKey.currentState.save();

    final authInstance = Provider.of<Authentication>(context, listen: false);

    setState(() {
      isLoading = true;
    });
    try {
      await authInstance.login(_email, _password);

      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    } catch (error) {
      authInstance.showError(error.toString(), context);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
              //Show a spinner when loading
            )
          : LayoutBuilder(builder: (context, constraint) {
              //Else show the main content
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight,
                      child: Image(
                        image: AssetImage("assets/images/background.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    // Constraint box is used to properly use singleChildScrollView with Spacer element inside column
                    // Column by default takes infinite height and singleChildScrollView gives a vertical scrollable area.
                    // Now using spacer is used to fill empty space but as a column is wrapped inside a singleChildScrollView it forces the column to take infinite space which gives a error
                    // So to limit the size of colummn constraints are applied so that its height is not more than screen height
                    ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraint.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AuthScreenIntro(), // The top header
                            Spacer(), //To fill all the available empty spaces
                            //Main Form widget starts here
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.horizontalBlockSize * 10,
                              ),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Form(
                                // Using a form key to communicate with the form element outside of the widget tree for saving and validating stuff
                                key: _formKey,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: SizeConfig.screenHeight * 0.05,
                                    ),
                                    // Email text field
                                    TextFormField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: kGreyLite,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(12, 10, 12, 10),
                                        labelText: "Email",
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide: BorderSide(color: kGrey),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      onSaved: (value) {
                                        _email = value;
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Please enter your email";
                                        }
                                        if (!value.contains("@") ||
                                            !value.contains(".")) {
                                          return "Please enter a valid email address";
                                        }

                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    // Password text field
                                    TextFormField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: kGreyLite,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(12, 10, 12, 10),
                                        labelText: "Password",
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide: BorderSide(color: kGrey),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                      ),
                                      obscureText:
                                          true, //to hide the characters
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.done,
                                      onSaved: (value) {
                                        _password = value;
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Please enter a password";
                                        }
                                        if (value.length < 6) {
                                          return "Please enter a password greator than 6 characters";
                                        }

                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    // Login Button
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 12),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          tryLogIn();
                                        },
                                        child: Text(
                                          "Log In",
                                          style: MyFonts.medium.factor(5),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          fixedSize: Size(1000, 50),
                                          primary: darkBlue,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    // This row widget creates two horizontal lines and places a text between them
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: (SizeConfig.screenWidth -
                                                      (2 *
                                                          SizeConfig
                                                              .horizontalBlockSize *
                                                          10)) /
                                                  2 -
                                              30,
                                          height: 2,
                                          color: kGrey.withOpacity(0.6),
                                        ),
                                        Text(
                                          "OR",
                                          style: MyFonts.medium
                                              .factor(4)
                                              .setColor(kGrey.withOpacity(0.9)),
                                        ),
                                        Container(
                                          width: (SizeConfig.screenWidth -
                                                      (2 *
                                                          SizeConfig
                                                              .horizontalBlockSize *
                                                          10)) /
                                                  2 -
                                              30,
                                          height: 2,
                                          color: kGrey.withOpacity(0.6),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SignInButton(
                                      Buttons.Google,
                                      onPressed: () => print("Hemlo"),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    // Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Don't have an account?  ",
                                          style: MyFonts.medium
                                              .tsFactor(18)
                                              .setColor(kGrey),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    SignUp.routeName,
                                                    (route) => false);
                                          },
                                          child: Text(
                                            "Sign Up",
                                            style: MyFonts.bold.tsFactor(18),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
    );
  }
}
