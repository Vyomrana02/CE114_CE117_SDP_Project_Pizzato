import 'package:ce114_ce117_sdp_project/Services/ManageMaps.dart';
import 'package:ce114_ce117_sdp_project/Views/Mycart.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Maps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
              child: Provider.of<GenerateMaps>(context, listen: false)
                  .fetchMaps()),
          Positioned(
            top: 720.0,
            left: 50.0,
            child: Container(
              color: Colors.white,
              height: 80.0,
              width: 300.0,
              child: Text(Provider.of<GenerateMaps>(context, listen: true)
                  .getMainAddress),
            ),
          ),
          Positioned(
              top: 50.0,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: MyCart(), type: PageTransitionType.fade));
                },
              ))
        ],
      )),
    );
  }
}