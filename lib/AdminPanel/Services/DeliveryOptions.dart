import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'AdminDetailHelpers.dart';

class DeliveryOptions with ChangeNotifier {
  showOrders(BuildContext context, String collection) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: const Color(0xff200B4B),
            ),
            height: MediaQuery.of(context).size.height * 0.50,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(collection)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: const Color(0xff200B4B),
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot documentSnapshot) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: const Color(0xff200B4B),
                              ),
                              child: ListTile(
                                trailing: IconButton(
                                  icon: const Icon(FontAwesomeIcons.mapPin),
                                  onPressed: () {
                                    showMap(
                                        context, documentSnapshot, collection);
                                  },
                                  color: Colors.green,
                                ),
                                subtitle: Text(
                                  documentSnapshot['name'],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                horizontalTitleGap: 5,
                                title: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.white,
                                      )),
                                  child: Text(
                                    documentSnapshot['address'],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      NetworkImage(documentSnapshot['image']),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }
                }),
          );
        });
  }

  Future manageOrders(BuildContext context, DocumentSnapshot documentSnapshot,
      String collection, String message) async {
    await FirebaseFirestore.instance.collection(collection).add({
      'image': documentSnapshot['image'],
      'name': documentSnapshot['username'],
      'pizza': documentSnapshot['pizza'],
      'address': documentSnapshot['address'],
      'location': documentSnapshot['location'],
    }).whenComplete(() {
      showMessage(context, message);
    });
  }

  showMap(BuildContext context, DocumentSnapshot documentSnapshot,
      String collection) {
    Provider.of<AdminDetailHelper>(context, listen: false)
        .getMarkerData(collection)
        .whenComplete(() {
      return showModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.50,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 150),
                    child: Divider(
                      thickness: 4.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 400,
                    height: MediaQuery.of(context).size.height * 0.48,
                    child:
                        Provider.of<AdminDetailHelper>(context, listen: false)
                            .showGoogleMaps(context, documentSnapshot),
                  ),
                ],
              ),
            );
          });
    });
  }

  showMessage(BuildContext context, String message) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: const Color(0xff200B4B)),
            height: 50,
            width: 400,
            child: Center(
              child: Text(
                message,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
          );
        });
  }
}