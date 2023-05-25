import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GenerateMaps extends ChangeNotifier {
  late Position position;
  Position get getPosition => position;
  String finalAddress = 'Searching Address...';
  String get getfinalAddress => finalAddress;
  late GoogleMapController googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  late GeoPoint geoPoint;
  GeoPoint get getgeoPoint => geoPoint;
  late String countryName, mainAddress = 'Mock address';
  String get getCountryName => countryName;
  String get getMainAddress => mainAddress;

  Future getCurrentLocation() async {
    Position positionData = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> address = await placemarkFromCoordinates(
        positionData.latitude, positionData.latitude);
    Placemark placeMark = address[0];
    String? name = placeMark.name;
    String? subLocality = placeMark.subLocality;
    String? locality = placeMark.locality;
    String? administrativeArea = placeMark.administrativeArea;
    String? postalCode = placeMark.postalCode;
    String? country = placeMark.country;
    mainAddress =
        "$name, $subLocality, $locality, $administrativeArea $postalCode, $country";
    // ignore: avoid_print
    print(mainAddress);
    finalAddress = mainAddress!;
    notifyListeners();

    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
  }

  getMarkers(double lat, double lng) {
    MarkerId markerId = MarkerId(lat.toString() + lng.toString());
    Marker marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(title: getMainAddress, snippet: 'Country name'),
    );
    markers[markerId] = marker;
  }

  Widget? fetchMaps() {
    return GoogleMap(
        mapType: MapType.hybrid,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onTap: (loc) async {
          List<Placemark> address =
              await placemarkFromCoordinates(loc.latitude, loc.latitude);
          Placemark placeMark = address[0];
          String? name = placeMark.name;
          String? subLocality = placeMark.subLocality;
          String? locality = placeMark.locality;
          String? administrativeArea = placeMark.administrativeArea;
          String? postalCode = placeMark.postalCode;
          String? country = placeMark.country;
          mainAddress =
              "$name, $subLocality, $locality, $administrativeArea $postalCode, $country";
          countryName = address.first.country!;
          geoPoint = GeoPoint(loc.latitude, loc.latitude);
          notifyListeners();
          markers == null
              ? getMarkers(loc.latitude, loc.latitude)
              : markers.clear();
          // ignore: avoid_print
          print(loc);
          // ignore: avoid_print
          print(countryName);
          // ignore: avoid_print
          print(mainAddress);
        },
        markers: Set<Marker>.of(markers.values),
        onMapCreated: (GoogleMapController mapController) {
          googleMapController = mapController;
          notifyListeners();
        },
        initialCameraPosition:
            const CameraPosition(target: LatLng(21.000, 45.000), zoom: 18.0));
  }
}
