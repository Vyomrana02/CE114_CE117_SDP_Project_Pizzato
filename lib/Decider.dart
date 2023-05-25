import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'AdminPanel/Views/AdminLogin.dart';
import 'Views/Login.dart';

class Decider extends StatelessWidget {
  //const Decider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Used for Color pattern used in this page
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                  0.2,
                  0.45,
                  0.6,
                  0.9
                ],
                    colors: [
                      Color(0xff200B4B),
                      Color(0xff201F22),
                      Color(0xff1A1031),
                      Color(0xff19181F),
                    ])),
          ),
          //Animation
          SizedBox(
            height: 900.0,
            width: 400.0,
            child: Lottie.asset('animation/choose.json'),
          ),
          //For Text Select Your Side
          Positioned(
            top: 80.0,
            left: 40.0,
            child: SizedBox(
              height: 200,
              width: 400,
              child: RichText(
                text: const TextSpan(
                    text: 'Select ',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 46.0),
                    children: [
                      TextSpan(
                        text: 'Your ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0),
                      ),
                      TextSpan(
                        text: 'Side',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0),
                      ),
                    ]),
              ),
            ),
          ),
          //For two material button Customer and Employee
          Positioned(
            top: 190.0,
            child: SizedBox(
              width: 400.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                      color: Colors.redAccent,
                      child: const Text('Customer',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: Login(),
                                type: PageTransitionType.rightToLeft));
                      }),
                  MaterialButton(
                      color: Colors.redAccent,
                      child: const Text('Employee',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: AdminLogin(),
                                type: PageTransitionType.rightToLeft));
                      })
                ],
              ),
            ),
          ),
          //Terms And Condition Text
          Positioned(
            top: 820.0,
            left: 20.0,
            right: 20.0,
            child: Container(
              width: 400.0,
              constraints: const BoxConstraints(maxHeight: 200),
              child: Column(
                children: const [
                  Text(
                    "By continuing you agree Pizzato's Terms of",
                    style:
                    TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Text(
                    "Services & Privacy Policy",
                    style:
                    TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}