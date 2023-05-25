import 'package:ce114_ce117_sdp_project/AdminPanel/Services/AdminDetailHelpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Provider/Authentication.dart';
import '../Services/DeliveryOptions.dart';
import 'AdminLogin.dart';

class AdminHomepage extends StatefulWidget {
  //const AdminHomepage({Key? key}) : super(key: key);

  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: const Color(0xff201F22),
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 250.0,
                child: UserAccountsDrawerHeader(
                  accountName: const Text('Pizzato'),
                  accountEmail: Text(Provider.of<Authentication>(context, listen: false).getEmail),
                  currentAccountPicture: CircleAvatar(
                    radius: 300.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(150.0),
                      child:Image.asset('animation/profile.jpg'),
                    ),

                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('animation/drawer-backgroung.jpeg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading:
                const Icon(FontAwesomeIcons.house, color: Colors.white),
                title:
                const Text('Home', style: TextStyle(color: Colors.white)),
                tileColor: Colors.blue[100],
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.peopleGroup,
                    color: Colors.white),
                tileColor: Colors.blue[100],
                title: const Text('Contact Us',
                    style: TextStyle(color: Colors.white)),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.circleInfo,
                    color: Colors.white),
                tileColor: Colors.blue[100],
                title: const Text('About Us',
                    style: TextStyle(color: Colors.white)),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.userShield,
                    color: Colors.white),
                tileColor: Colors.blue[100],
                title: const Text('Privacy Policy',
                    style: TextStyle(color: Colors.white)),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.addressBook,
                    color: Colors.white),
                tileColor: Colors.blue[100],
                title: const Text('Send FeedBack',
                    style: TextStyle(color: Colors.white)),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // ignore: avoid_print
          print('Working');
        },
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
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
            appBar(context),
            dateChips(context),
            orderData(context)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatingActionButton(context),
    );
  }

  Widget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
            icon: const Icon(FontAwesomeIcons.rightFromBracket),
            onPressed: () async {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.remove('uid');
              // ignore: avoid_print
              print("~~~~~~~ User signout ~~~~~~");
              if (!mounted) return;
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: AdminLogin(),
                      type: PageTransitionType.leftToRight));
            }),
      ],
      centerTitle: true,
      title: const Text(
        'Orders',
        style: TextStyle(
            color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget dateChips(BuildContext context) {
    return Positioned(
      top: 120.0,
      child: SizedBox(
        width: 400.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ActionChip(
              backgroundColor: Colors.purple,
              label: const Text('Today',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold)),
              onPressed: () {},
            ),
            ActionChip(
              backgroundColor: Colors.purple,
              label: const Text('This Week',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold)),
              onPressed: () {},
            ),
            ActionChip(
              backgroundColor: Colors.purple,
              label: const Text('This Month',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold)),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget orderData(BuildContext context) {
    return Positioned(
        top: 200.0,
        child: SizedBox(
          height: 800.0,
          width: 400.0,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('adminCollections')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView(
                    children: snapshot.data!.docs
                        .map((DocumentSnapshot documentSnapshot) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.deepPurple),
                      child: ListTile(
                        onTap: () {
                          Provider.of<AdminDetailHelper>(context, listen: false)
                              .detailSheet(context, documentSnapshot, 'adminCollections');
                        },
                        trailing: IconButton(
                          icon: const Icon(FontAwesomeIcons.magnet,
                              color: Colors.white),
                          onPressed: () {},
                        ),
                        subtitle: Text(documentSnapshot['address'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold)),
                        title: Text(documentSnapshot['pizza'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                        leading: CircleAvatar(
                          radius: 25.0,
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              NetworkImage(documentSnapshot['image']!),
                        ),
                      ),
                    ),
                  );
                }).toList());
              }
            },
          ),
        ));
  }

  Widget floatingActionButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FloatingActionButton(
          heroTag: 'Cancel',
          onPressed: () {
            Provider.of<DeliveryOptions>(context, listen: false)
                .showOrders(context, 'cancelledOrders');
          },
          backgroundColor: Colors.redAccent,
          child: const Icon(FontAwesomeIcons.ban, color: Colors.white),
        ),
        FloatingActionButton(
          heroTag: 'Confirm',
          onPressed: () {
            Provider.of<DeliveryOptions>(context, listen: false)
                .showOrders(context, 'deliveredOrders');
          },
          backgroundColor: Colors.greenAccent,
          child: const Icon(FontAwesomeIcons.check, color: Colors.white),
        ),
      ],
    );
  }
}