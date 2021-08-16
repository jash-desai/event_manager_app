import 'package:event_manager/screens/calendar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';

import '../globals/myFonts.dart';
import '../providers/authentication.dart';
import '../screens/login.dart';
import '../widgets/auth_screen_intro.dart';
import '../globals/sizeConfig.dart';
import '../globals/myColors.dart';

class SignUp extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  var isLoading = false;

  String _email, _password, _name;

  void trySignIn() async {
    if (!_formKey.currentState.validate()) {
      return null;
    }
    setState(() {
      isLoading = true;
    });
    _formKey.currentState.save();
    final authInstance = Provider.of<Authentication>(context, listen: false);

    try {
      await authInstance.signUp(_name, _email, _password);

      Navigator.of(context).pushReplacementNamed(CalendarScreen.routeName);
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
          ? Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (context, constraint) {
                return SingleChildScrollView(
                  child: Stack(
                    children: [
                      /* Background Image */
                      Container(
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight,
                        child: Image(
                          image: AssetImage("assets/images/background.jpg"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraint.maxHeight),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AuthScreenIntro(),
                              Spacer(),
                              Container(
                                height: 550,
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      SizeConfig.horizontalBlockSize * 5,
                                ),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                /* Form Widget Started */
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: SizeConfig.screenHeight * 0.05,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: kGreyLite,
                                          contentPadding: EdgeInsets.fromLTRB(
                                              12, 10, 12, 10),
                                          labelText: "Name",
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0)),
                                            borderSide:
                                                BorderSide(color: kGrey),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0)),
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Please enter your name";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          _name = value;
                                        },
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: kGreyLite,
                                          contentPadding: EdgeInsets.fromLTRB(
                                              12, 10, 12, 10),
                                          labelText: "Email",
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0)),
                                            borderSide:
                                                BorderSide(color: kGrey),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0)),
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                          ),
                                        ),
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
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: kGreyLite,
                                          contentPadding: EdgeInsets.fromLTRB(
                                              12, 10, 12, 10),
                                          labelText: "Password",
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0)),
                                            borderSide:
                                                BorderSide(color: kGrey),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0)),
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                          ),
                                        ),
                                        controller: _passwordController,
                                        onFieldSubmitted: (value) {
                                          _passwordController.text = value;
                                        },
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
                                        obscureText: true,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        textInputAction: TextInputAction.next,
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: kGreyLite,
                                          contentPadding: EdgeInsets.fromLTRB(
                                              12, 10, 12, 10),
                                          labelText: "Confirm Password",
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0)),
                                            borderSide:
                                                BorderSide(color: kGrey),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0)),
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Please enter your password again";
                                          }
                                          if (value !=
                                              _passwordController.text) {
                                            return "Passwords do not match";
                                          }

                                          return null;
                                        },
                                        obscureText: true,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        textInputAction: TextInputAction.done,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 12),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            trySignIn();
                                          },
                                          child: Text(
                                            "Sign Up",
                                            style: MyFonts.medium.factor(5),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            fixedSize: Size(1000, 50),
                                            // primary: darkBlue,
                                            primary: Colors.purple[700],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
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
                                                .setColor(
                                                    kGrey.withOpacity(0.9)),
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
                                        height: 10,
                                      ),
                                      SignInButton(
                                        Buttons.Google,
                                        onPressed: () => print("Hemlo"),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      // Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Already have an account?  ",
                                            style: MyFonts.medium
                                                .tsFactor(18)
                                                .setColor(kGrey),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                      Login.routeName,
                                                      (route) => false);
                                            },
                                            child: Text(
                                              "Log In",
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
              },
            ),
    );
  }
}
