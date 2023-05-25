import 'package:ce114_ce117_sdp_project/Helpers/Footers.dart';
import 'package:flutter/material.dart';
import 'package:ce114_ce117_sdp_project/Helpers/Middle.dart';
import 'package:ce114_ce117_sdp_project/Helpers/Headers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../Provider/Authentication.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Container(
          color: const Color(0xff201F22),
          child: ListView(
            children: [
              SizedBox(
                height: 250.0,
                child: UserAccountsDrawerHeader(
                  accountName: const Text('Pizzato'),
                  accountEmail: Text(
                      Provider.of<Authentication>(context, listen: false)
                          .getEmail),
                  currentAccountPicture: CircleAvatar(
                    radius: 300.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(150.0),
                      child: Image.asset('animation/profile.jpg'),
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
      body: SingleChildScrollView(
          child: Container(
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
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Headers().appBar(context),
              Headers().headerText(),
              const Divider(
                color: Colors.white,
                thickness: 3.0,
              ),
              MiddleHelpers().favouriteFood(),
              MiddleHelpers().favouriteFoodData(context, 'favourite'),
              MiddleHelpers().businessFood(),
              MiddleHelpers().businessData(context, 'buisness'),
            ],
          ),
        ),
      )),
      floatingActionButton: Footers().floatingActionButton(context),
    );
  }
}