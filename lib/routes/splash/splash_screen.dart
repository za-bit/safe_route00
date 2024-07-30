


import 'package:flutter/material.dart';

import '../login/login.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2),(){
      Navigator.pushReplacementNamed(context, Login.routeName);
    });
    return Scaffold(
      body: Image.asset(
        "assets/splash123.png",
        fit: BoxFit.fill,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }

// void checkLoggedInUser(){
//     var authProvider=Provider.of<AuthProvider>(context,listen:false);
//     if(authProvider.isUserLoggedInBefore()){
//
//     }
}

