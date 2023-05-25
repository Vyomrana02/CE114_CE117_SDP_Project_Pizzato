import 'package:ce114_ce117_sdp_project/Views/Login.dart';
import 'package:ce114_ce117_sdp_project/Views/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Headers extends ChangeNotifier {

  Widget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xff200B4B),
      centerTitle: true,
      actions: [
        IconButton(
            icon: const Icon(FontAwesomeIcons.rightFromBracket),
            onPressed: () async {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.remove('uid');
              //ignore: avoid_print
              print(userUid);
              // ignore: avoid_print
              print("~~~~~~~ User signout ~~~~~~");
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: Login(), type: PageTransitionType.leftToRight));
            }),
      ],
      title: const Text(
        'Home',
        style: TextStyle(
            color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget headerText() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 350.0),
        child: RichText(
          text: const TextSpan(
              text: 'What would you like',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  fontSize: 29.0),
              children: <TextSpan>[
                TextSpan(
                    text: '\nto eat?',
                    style: TextStyle(
                        fontSize: 46.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.greenAccent))
              ]),
        ),
      ),
    );
  }
}