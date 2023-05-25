import 'package:ce114_ce117_sdp_project/Provider/Calculations.dart';
import 'package:ce114_ce117_sdp_project/Provider/Payment.dart';
import 'package:ce114_ce117_sdp_project/Services/ManageData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../Provider/Authentication.dart';
import '../Services/ManageMaps.dart';
import 'Homepage.dart';
import 'SplashScreen.dart';

class MyCart extends StatefulWidget {
  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  late Razorpay razorpay;
  int price = 400;
  late int total;

  @override
  void initState() {
    razorpay = Razorpay();
    razorpay.on(
        Razorpay.EVENT_PAYMENT_SUCCESS,
        Provider.of<PaymentHelper>(context, listen: false)
            .handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        Provider.of<PaymentHelper>(context, listen: false).handlePaymentError);
    razorpay.on(
        Razorpay.EVENT_EXTERNAL_WALLET,
        Provider.of<PaymentHelper>(context, listen: false)
            .handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    razorpay.clear();
    super.dispose();
  }

  Future checkOut(DocumentSnapshot documentSnapshot) async {
    var options = {
      'key': 'rzp_test_SbUJ5YD66IIFyY',
      'amount': documentSnapshot['price'] * 100,
      'name':
          Provider.of<Authentication>(context, listen: false).getEmail == null
              ? userEmail
              : Provider.of<Authentication>(context, listen: false).getEmail,
      'description': 'Payment',
      'prefill': {
        'contact': '9999999999',
        'email': Provider.of<Authentication>(context, listen: false).getEmail,
      },
      'external': {
        'wallet': ['paytm']
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

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
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBar(context),
              headerText(),
              cartData(),
            ],
          ),
        ),
      ),
      /*floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatingActionButton(),*/
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
            onPressed: () async {
              /*Provider.of<ManageData>(context, listen: false)
                  .deleteData(context);
              Provider.of<Calculations>(context, listen: false).cartData = 0;*/
            },
          ),
        ),
      ]),
    );
  }

  Widget headerText() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
      child: Column(
        children: const [
          Text(
            'Your',
            style: TextStyle(color: Colors.white, fontSize: 22.0),
          ),
          Text(
            'Cart',
            style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget cartData() {
    return SizedBox(
      height: 600.0,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('myOrders')
            .where('email',
                isEqualTo: Provider.of<Authentication>(context, listen: false)
                    .getEmail)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            );
          } else {
            return ListView(
                children: (snapshot.data!)
                    .docs
                    .map((DocumentSnapshot documentSnapshot) {
              return GestureDetector(
                onLongPress: () {
                  placeOrder(context, documentSnapshot);
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.white.withOpacity(0.8),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.lightBlueAccent,
                              blurRadius: 2,
                              spreadRadius: 2)
                        ]),
                    height: 250.0,
                    width: 400.0,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 230.0,
                          child: Image.network(documentSnapshot['image']),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              documentSnapshot['name'],
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                              ),
                            ),
                            Text(
                              'Price : ${documentSnapshot['price'].toString()}',
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 21.0,
                              ),
                            ),
                            Text(
                              'Onion : ${documentSnapshot['onion'].toString()}',
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              'Cheese : ${documentSnapshot['cheese'].toString()}',
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              'Bacon : ${documentSnapshot['beacon'].toString()}',
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 18.0,
                              ),
                            ),
                            CircleAvatar(
                              child: Text(documentSnapshot['size'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                  )),
                            ),
                            IconButton(
                              icon: const Icon(
                                FontAwesomeIcons.trashCan,
                                color: Colors.red,
                              ),
                              onPressed: () async {
                                Provider.of<ManageData>(context, listen: false)
                                    .deleteData(documentSnapshot.id);
                                Provider.of<Calculations>(context,
                                        listen: false)
                                    .cartData = 0;
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList());
          }
        },
      ),
    );
  }

  placeOrder(BuildContext context, DocumentSnapshot documentSnapshot) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * .40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: const Color(0xFF191531)),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    color: Colors.white,
                    thickness: 4.0,
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: 30.0,
                            child: Text(
                                'Time : ${Provider.of<PaymentHelper>(context, listen: true).deliveryTiming.format(context)} ',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0))),
                        SizedBox(
                            height: 30.0,
                            child: Text(
                                'Location : ${Provider.of<GenerateMaps>(context, listen: true).getMainAddress}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0))),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                        backgroundColor: Colors.redAccent,
                        onPressed: () {
                          Provider.of<PaymentHelper>(context, listen: false)
                              .selectTime(context);
                        },
                        child: const Icon(
                          FontAwesomeIcons.clock,
                          color: Colors.white,
                        )),
                    FloatingActionButton(
                        backgroundColor: Colors.lightBlueAccent,
                        onPressed: () {
                          Provider.of<PaymentHelper>(context, listen: false)
                              .selectLocation(context);
                        },
                        child: const Icon(
                          FontAwesomeIcons.mapPin,
                          color: Colors.white,
                        )),
                    FloatingActionButton(
                        backgroundColor: Colors.lightGreenAccent,
                        onPressed: () async {
                          await checkOut(documentSnapshot).whenComplete(() {
                            Provider.of<PaymentHelper>(context, listen: false)
                                .showCheckoutButtonMethod();
                          });
                        },
                        child: const Icon(
                          FontAwesomeIcons.paypal,
                          color: Colors.black,
                        )),
                  ],
                ),
                Provider.of<PaymentHelper>(context, listen: false)
                        .showCheckoutButton
                    ? MaterialButton(
                        child: const Text(
                          'Place Order',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('adminCollections')
                              .add({
                            'location': Provider.of<GenerateMaps>(context,
                                    listen: false)
                                .geoPoint,
                            'username': Provider.of<Authentication>(context,
                                            listen: false)
                                        .getEmail ==
                                    null
                                ? userEmail
                                : Provider.of<Authentication>(context,
                                        listen: false)
                                    .getEmail,
                            'image': documentSnapshot['image'],
                            'pizza': documentSnapshot['name'],
                            'price': documentSnapshot['price'],
                            'time': Provider.of<PaymentHelper>(context,
                                    listen: false)
                                .deliveryTiming
                                .format(context),
                            'address': Provider.of<GenerateMaps>(context,
                                    listen: false)
                                .getMainAddress,
                            'size': documentSnapshot['size'],
                            'onion': documentSnapshot['onion'],
                            'cheese': documentSnapshot['cheese'],
                            'beacon': documentSnapshot['beacon']
                          });
                          if (!mounted) return;
                          Provider.of<ManageData>(context, listen: false)
                              .deleteData(documentSnapshot.id);
                        })
                    : Container()
              ],
            ),
          );
        });
  }
}
