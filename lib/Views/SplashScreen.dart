import 'dart:async';
import 'package:ce114_ce117_sdp_project/Decider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? userUid;
String? userEmail;

class Splashscreen extends StatefulWidget {
  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  Future getUid() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userUid = sharedPreferences.getString('uid');
    userEmail = sharedPreferences.getString('userEmail');
    // ignore: avoid_print
    print(userUid);
  }

  /*
      init state function uses a timer of 3 seconds then send flow of code to next page called Decider
  */
  @override
  void initState() {
    // ignore: avoid_print
    print(userUid);
    getUid().whenComplete(() => {
          Timer(
              const Duration(seconds: 3),
              () => Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: Decider(),
                      type: PageTransitionType.leftToRightWithFade)))
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 200.0,
            width: 400.0,
            child: Lottie.asset('animation/chef.json'),
          ),
          RichText(
              text: const TextSpan(
                  text: 'Piz',
                  style: TextStyle(
                      fontSize: 56.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  children: <TextSpan>[
                TextSpan(
                    text: 'z',
                    style: TextStyle(
                        fontSize: 56.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
                TextSpan(
                    text: 'ato',
                    style: TextStyle(
                      fontSize: 56.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ))
              ]))
        ],
      ),
    );
  }
}