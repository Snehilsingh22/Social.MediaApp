import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phone_auth/resposive/mobile_screen_layout.dart';
import 'package:phone_auth/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<SplashScreen> {
  static const String KEYLOGIN = "Login";
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () async {
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => PhoneNoScreen()));
      var sharedPref = await SharedPreferences.getInstance();
      var isLoggedin = sharedPref.getBool(KEYLOGIN);

      print(isLoggedin);
      if (isLoggedin != null) {
        if (isLoggedin) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => MobileScreenLayout()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
      // if (FirebaseAuth.instance.currentUser == null) {
      //   Navigator.pushReplacement(
      //       context, MaterialPageRoute(builder: (context) => PhoneNoScreen()));
      // } else {
      //   Navigator.pushReplacement(
      //       context, MaterialPageRoute(builder: (context) => HomeScreen()));
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            child: Center(
              child: Image.asset(
                'assets/insta2.gif',
                height: 300,
                width: 300,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  // void isSignedIn() {
  //   final ap = Provider.of<AuthProvider>(context, listen: false);
  //   final auth = FirebaseAuth.instance;
  // }
}
