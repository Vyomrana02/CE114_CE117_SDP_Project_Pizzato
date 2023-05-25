import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'DeliveryOptions.dart';

class AdminDetailHelper with ChangeNotifier {
  late GoogleMapController googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  initMarker(collection, collectionId) {
    var varMarkerId = collectionId;
    final MarkerId markerId = MarkerId(varMarkerId);
    final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(
            collection['location'].latitude, collection['location'].longitude),
        infoWindow: InfoWindow(title: 'Order', snippet: collection['address']));
    markers[markerId] = marker;
  }

  getMarkerData(String collection) async {
    FirebaseFirestore.instance
        .collection(collection)
        .get()
        .then((docData) {
      if (docData.docs.isNotEmpty) {
        for (int i = 0; i < docData.docs.length; i++) {
          initMarker(docData.docs[i].data(), docData.docs[i].id);
          // ignore: avoid_print
          print(docData.docs[i].data());
        }
      }
    });
  }

  showGoogleMaps(BuildContext context, DocumentSnapshot documentSnapshot) {
    return GoogleMap(
      mapType: MapType.hybrid,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: true,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      mapToolbarEnabled: true,
      buildingsEnabled: true,
      initialCameraPosition: CameraPosition(
        zoom: 17,
        tilt: 1.0,
        target: LatLng(documentSnapshot['location'].latitude,
            documentSnapshot['location'].longitude),
      ),
      onMapCreated: (GoogleMapController mapController) {
        googleMapController = mapController;
        notifyListeners();
      },
    );
  }

  detailSheet(BuildContext context, DocumentSnapshot documentSnapshot, String collection) {
    getMarkerData(collection);
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.95,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: const Color(0xFF200B4B)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 150),
                  child: Divider(
                    thickness: 4.0,
                    color: Colors.white,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Icon(EvaIcons.person, color: Colors.red),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(documentSnapshot['username'],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0)),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          const Icon(FontAwesomeIcons.mapPin,
                              color: Colors.lightBlueAccent),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              constraints: const BoxConstraints(maxWidth: 360.0),
                              child: Text(documentSnapshot['address'],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0)),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 400,
                    width: 400,
                    child: showGoogleMaps(context, documentSnapshot),
                  ),
                ),
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.clock,
                          color: Colors.lightGreenAccent,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            documentSnapshot['time'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.indianRupeeSign,
                          color: Colors.lightBlueAccent,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            documentSnapshot['price'].toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                )),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: Colors.white)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                radius: 50.0,
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(
                                  documentSnapshot['image'],
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Pizza : ${documentSnapshot['pizza']}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Cheese : ${documentSnapshot['cheese']},',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Onion : ${documentSnapshot['onion']},',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Beacon : ${documentSnapshot['beacon']}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.deepPurple,
                                child: Text(
                                  documentSnapshot['size'],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ])
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    width: 400.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Provider.of<DeliveryOptions>(context, listen: false)
                                .manageOrders(context, documentSnapshot,
                                'cancelledOrders', 'Delivery Cancelled');
                          },
                          icon: const Icon(FontAwesomeIcons.eye, color: Colors.white),
                          label: const Text(
                            'Skip',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Provider.of<DeliveryOptions>(context, listen: false)
                                .manageOrders(context, documentSnapshot,
                                'deliveredOrders', 'Delivery Accepted');
                          },
                          icon: const Icon(FontAwesomeIcons.delicious,
                              color: Colors.white),
                          label: const Text(
                            'Deliver',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(FontAwesomeIcons.phone, color: Colors.white),
                      label: const Text(
                        'Contact the owner',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}