import 'package:ce114_ce117_sdp_project/Services/ManageData.dart';
import 'package:ce114_ce117_sdp_project/Views/Detailedscreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class MiddleHelpers extends ChangeNotifier {

  Widget favouriteFood() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: RichText(
        text: TextSpan(
            text: 'Favourite',
            style: const TextStyle(
                shadows: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 1,
                  )
                ],
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 36.0),
            children: <TextSpan>[
              TextSpan(
                  text: ' dishes',
                  style: TextStyle(
                      shadows: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 0,
                        )
                      ],
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700))
            ]),
      ),
    );
  }

  Widget favouriteFoodData(BuildContext context, String collection) {
    return SizedBox(
      height: 300.0,
      child: FutureBuilder(
        future: Provider.of<ManageData>(context, listen: false)
            .fetchData(collection),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset('animation/delivery-guy.json'),
            );
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: DetailedScreen(
                              queryDocumentSnapshot: snapshot.data[index]),
                          type: PageTransitionType.topToBottom));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 300.0,
                    width: 200.0,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(40.0)),
                        color: Colors.white.withOpacity(0.8),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.lightBlueAccent,
                              blurRadius: 2,
                              spreadRadius: 3)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 180.0,
                            child: Image.network(
                                snapshot.data[index].data()['image']),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Center(
                              child: Text(
                                snapshot.data[index].data()['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 22.0,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 4.0, left: 30.0),
                            child: Text(
                              snapshot.data[index].data()['category'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.cyan,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow.shade700,
                                    ),
                                    Text(
                                      snapshot.data[index].data()['rating'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey,
                                        fontSize: 16.0,
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 40.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                          FontAwesomeIcons.indianRupeeSign,
                                          size: 16.0),
                                      Text(
                                        snapshot.data[index]
                                            .data()['price']
                                            .toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                          fontSize: 16.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget businessFood() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: RichText(
        text: TextSpan(
            text: 'Business',
            style: const TextStyle(
                shadows: [
                  BoxShadow(
                    color: Colors.redAccent,
                    blurRadius: 1,
                  )
                ],
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 36.0),
            children: <TextSpan>[
              TextSpan(
                  text: ' lunch',
                  style: TextStyle(
                      shadows: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 0,
                        )
                      ],
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700))
            ]),
      ),
    );
  }

  Widget businessData(BuildContext context, String collection) {
    return SizedBox(
      height: 400.0,
      child: FutureBuilder(
          future: Provider.of<ManageData>(context, listen: false)
              .fetchData(collection),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset('animation/delivery-guy.json'),
              );
            } else {
              return ListView.builder(
                  //scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: DetailedScreen(
                                    queryDocumentSnapshot:
                                        snapshot.data[index]),
                                type: PageTransitionType.topToBottom));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Container(
                          //height: 300.0,
                          //width: 600.0,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(40.0)),
                              color: Colors.white.withOpacity(0.8),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.redAccent,
                                    blurRadius: 5,
                                    spreadRadius: 3)
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data[index].data()['name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 26.0,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data[index].data()['category'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.cyan,
                                        fontSize: 22.0,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                            FontAwesomeIcons.indianRupeeSign,
                                            size: 10.0),
                                        Text(
                                          snapshot.data[index]
                                              .data()['notPrice']
                                              .toString(),
                                          style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.cyan,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                            FontAwesomeIcons.indianRupeeSign,
                                            size: 10.0),
                                        Text(
                                          snapshot.data[index]
                                              .data()['price']
                                              .toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w200,
                                            color: Colors.black,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 200.0,
                                width: 200.0,
                                child: Image.network(
                                    snapshot.data[index].data()['image']),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}