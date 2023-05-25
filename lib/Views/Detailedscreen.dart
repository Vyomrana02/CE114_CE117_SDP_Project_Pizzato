import 'package:ce114_ce117_sdp_project/Provider/Authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ce114_ce117_sdp_project/Views/Homepage.dart';
import 'package:provider/provider.dart';
import '../Provider/Calculations.dart';
import 'Mycart.dart';

class DetailedScreen extends StatefulWidget {
  final QueryDocumentSnapshot queryDocumentSnapshot;

  DetailedScreen({required this.queryDocumentSnapshot});
  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {

  int cheeseValue = 0;
  int baconValue = 0;
  int onionValue = 0;
  int totalItems = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBar(context),
              pizzaImage(),
              middleData(),
              footerDetails(),
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatingActionButton(),
    );
  }

  Widget appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: HomeScreen(),
                    type: PageTransitionType.rightToLeftWithFade));
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 300.0),
          child: IconButton(
            icon: const Icon(
              FontAwesomeIcons.trashCan,
              color: Colors.red,
            ),
            onPressed: () {
              Provider.of<Calculations>(context, listen: false).removeAllData();
            },
          ),
        ),
      ]),
    );
  }

  Widget pizzaImage() {
    return Center(
      child: SizedBox(
        height: 280.0,
        child: Container(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Image.network(widget.queryDocumentSnapshot['image']),
        ),
      ),
    );
  }

  Widget middleData() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 300.0),
              child: Text(
                widget.queryDocumentSnapshot['name'],
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 36.0),
              ),
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow.shade700, size: 20.0),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    widget.queryDocumentSnapshot['rating'],
                    style: TextStyle(fontSize: 20.0, color: Colors.grey.shade500),
                  ),
                )
              ],
            ),
            Row(
              children: [
                const Icon(
                  FontAwesomeIcons.indianRupeeSign,
                  size: 20.0,
                  color: Colors.cyan,
                ),
                Text(
                  widget.queryDocumentSnapshot['price'].toString(),
                  style: const TextStyle(
                      fontSize: 22.0,
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        )
      ],
    );
  }

  Widget footerDetails() {
    return SizedBox(
        height: 300.0,
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    color: Colors.white.withOpacity(0.8),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade500,
                          blurRadius: 2,
                          spreadRadius: 2)
                    ]),
                height: 300.0,
                width: 400.0,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 40.0, right: 20.0, left: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Add more stuff',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Cheese',
                            style: TextStyle(
                                color: Colors.grey.shade500, fontSize: 22.0),
                          ),
                          Row(children: [
                            IconButton(
                              icon: const Icon(EvaIcons.minus),
                              onPressed: () {
                                Provider.of<Calculations>(context,
                                        listen: false)
                                    .minusCheese();
                              },
                            ),
                          ]),
                          Text(
                            Provider.of<Calculations>(context, listen: true)
                                .getCheeseValue
                                .toString(),
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.grey.shade500),
                          ),
                          IconButton(
                            icon: const Icon(EvaIcons.plus),
                            onPressed: () {
                              Provider.of<Calculations>(context, listen: false)
                                  .addCheese();
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Bacon',
                            style: TextStyle(
                                color: Colors.grey.shade500, fontSize: 22.0),
                          ),
                          Row(children: [
                            IconButton(
                              icon: const Icon(EvaIcons.minus),
                              onPressed: () {
                                Provider.of<Calculations>(context,
                                        listen: false)
                                    .minusBacon();
                              },
                            ),
                          ]),
                          Text(
                            Provider.of<Calculations>(context, listen: true)
                                .getBaconValue
                                .toString(),
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.grey.shade500),
                          ),
                          IconButton(
                            icon: const Icon(EvaIcons.plus),
                            onPressed: () {
                              Provider.of<Calculations>(context, listen: false)
                                  .addBacon();
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Onion',
                            style: TextStyle(
                                color: Colors.grey.shade500, fontSize: 22.0),
                          ),
                          Row(children: [
                            IconButton(
                              icon: const Icon(EvaIcons.minus),
                              onPressed: () {
                                Provider.of<Calculations>(context,
                                        listen: false)
                                    .minusOnion();
                              },
                            ),
                          ]),
                          Text(
                            Provider.of<Calculations>(context, listen: true)
                                .getOnionValue
                                .toString(),
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.grey.shade500),
                          ),
                          IconButton(
                            icon: const Icon(EvaIcons.plus),
                            onPressed: () {
                              Provider.of<Calculations>(context, listen: false)
                                  .addOnion();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              GestureDetector(
                  onTap: () {
                    Provider.of<Calculations>(context, listen: false)
                        .selectSmallSize();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Provider.of<Calculations>(context, listen: true)
                              .smallTapped
                          ? Colors.lightBlue
                          : Colors.white,
                      border: Border.all(color: Colors.lightBlue),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'S',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  )),
              GestureDetector(
                  onTap: () {
                    Provider.of<Calculations>(context, listen: false)
                        .selectMediumSize();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Provider.of<Calculations>(context, listen: true)
                              .mediumTapped
                          ? Colors.lightBlue
                          : Colors.white,
                      border: Border.all(color: Colors.lightBlue),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'M',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  )),
              GestureDetector(
                  onTap: () {
                    Provider.of<Calculations>(context, listen: false)
                        .selectLargeSize();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Provider.of<Calculations>(context, listen: true)
                              .largeTapped
                          ? Colors.lightBlue
                          : Colors.white,
                      border: Border.all(color: Colors.lightBlue),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'L',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ))
            ]),
          )
        ]));
  }

  Widget floatingActionButton() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      GestureDetector(
        onTap: () {
          Provider.of<Calculations>(context, listen: false).addToCart(context, {
            'image': widget.queryDocumentSnapshot['image'],
            'name': widget.queryDocumentSnapshot['name'],
            'price': widget.queryDocumentSnapshot['price'],
            'onion':
                Provider.of<Calculations>(context, listen: false).getOnionValue,
            'beacon':
                Provider.of<Calculations>(context, listen: false).getBaconValue,
            'cheese': Provider.of<Calculations>(context, listen: false)
                .getCheeseValue,
            'size': Provider.of<Calculations>(context, listen: false).getSize,
            'email': Provider.of<Authentication>(context, listen: false).getEmail,
            //'cartName': cartName.last
          });
          Provider.of<Calculations>(context, listen: false).removeAllData();
        },
        child: Container(
          width: 250.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: const Center(
            child: Text(
              'Add to cart',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
      Stack(
        children: [
          FloatingActionButton(
            backgroundColor: Colors.lightBlue,
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: MyCart(), type: PageTransitionType.bottomToTop));
            },
            child: const Icon(
              Icons.shopping_basket,
              color: Colors.black,
            ),
          ),
          Positioned(
            left: 35,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 10,
              child: Text(
                Provider.of<Calculations>(context, listen: true)
                    .getCartData
                    .toString(),
                style:
                    const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ]);
  }
}