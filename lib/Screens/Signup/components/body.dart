import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grow_more/Admin/home.dart';
import 'package:grow_more/Screens/Login/login_screen.dart';
import 'package:grow_more/Screens/Signup/components/background.dart';
import 'package:grow_more/Screens/Signup/components/or_divider.dart';
import 'package:grow_more/Screens/Signup/components/social_icon.dart';
import 'package:grow_more/components/already_have_an_account_acheck.dart';
import 'package:grow_more/components/rounded_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grow_more/components/text_field_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final username_controller = TextEditingController();
  final email_controller = TextEditingController();
  final pass = TextEditingController();
  final confirmPass = TextEditingController();

  SharedPreferences logindata;
  bool newuser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);

    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    username_controller.dispose();
    email_controller.dispose();
    pass.dispose();
    confirmPass.dispose();
    logindata.setString('username', '');
    super.dispose();
  }

  moveToHome(BuildContext context) async {
    String username = username_controller.text;

    if (_formKey.currentState.validate()) {
      logindata.setBool('login', false);
      logindata.setString('username', username);

      await Future.delayed(Duration(seconds: 1));
      await Navigator.of(context).pushNamed(HomePage.routeName);
    }
  }

  bool textVisibility = true;

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "SIGNUP",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  "assets/icons/signup.svg",
                  height: size.height * 0.20,
                ),
                TextFieldContainer(
                  child: TextFormField(
                    controller: username_controller,
                    validator: (value) {
                      if (value.isEmpty && value.length < 2) {
                        return "Username Cannot be empty";
                      }
                      return null;
                    },
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: kPrimaryColor,
                      ),
                      hintText: "Enter your name",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextFieldContainer(
                  child: TextFormField(
                    controller: email_controller,
                    validator: (value) => EmailValidator.validate(value)
                        ? null
                        : "Please enter a valid email",
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: kPrimaryColor,
                      ),
                      hintText: "Enter your email address",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextFieldContainer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      ),
                      hintText: "Enter password",
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            if (textVisibility == true) {
                              textVisibility = false;
                            } else if (textVisibility == false) {
                              textVisibility = true;
                            }
                          });
                        },
                        icon: Icon(
                          Icons.visibility,
                        ),
                        color: kPrimaryColor,
                      ),

                    ),
                    obscureText: textVisibility,
                    controller: pass,
                    validator: (val) {
                      final isDigitsOnly = int.tryParse(val);
                      if (isDigitsOnly == null) {
                        return "Password should be a numeric digits!!!";
                      } else if (val.isEmpty && val.length < 8) {
                        return 'Password length should be 8 numeric digits';
                      }
                      return null;
                    },
                  ),
                ),
                TextFieldContainer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      ),
                      hintText: "Confirm password",
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            if (textVisibility == true) {
                              textVisibility = false;
                            } else if (textVisibility == false) {
                              textVisibility = true;
                            }
                          });
                        },
                        icon: Icon(
                          Icons.visibility,
                        ),
                        color: kPrimaryColor,
                      ),
                    ),
                    obscureText: textVisibility,
                    controller: confirmPass,
                    validator: (val) {
                      if (val.isEmpty) return 'Empty';
                      if (val != pass.text) return 'Not Match';
                      return null;
                    },
                  ),
                ),
                RoundedButton(
                  text: "SIGNUP",
                  press: () => moveToHome(context),
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                ),
                OrDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SocalIcon(
                      iconSrc: "assets/icons/facebook.svg",
                      press: () {},
                    ),
                    SocalIcon(
                      iconSrc: "assets/icons/twitter.svg",
                      press: () {},
                    ),
                    SocalIcon(
                      iconSrc: "assets/icons/google-plus.svg",
                      press: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
