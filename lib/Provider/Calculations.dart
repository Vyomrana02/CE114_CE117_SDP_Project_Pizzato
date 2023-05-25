import 'package:flutter/material.dart';
import 'package:ce114_ce117_sdp_project/Services/ManageData.dart';
import 'package:provider/provider.dart';

class Calculations with ChangeNotifier {
  int cheeseValue = 0, baconValue = 0, onionValue = 0, cartData = 0;
  late String size;
  String get getSize => size;
  bool isSelected = false,
      smallTapped = false,
      mediumTapped = false,
      largeTapped = false,
      selected = false;
  int get getCheeseValue => cheeseValue;
  int get getBaconValue => baconValue;
  int get getOnionValue => onionValue;
  int get getCartData => cartData;
  bool get getSelected => selected;

  addCheese() {
    if (cheeseValue < 10) {
      cheeseValue++;
    }
    notifyListeners();
  }

  addBacon() {
    if (baconValue < 10) {
      baconValue++;
    }
    notifyListeners();
  }

  addOnion() {
    if (onionValue < 10) {
      onionValue++;
    }
    notifyListeners();
  }

  minusCheese() {
    if (cheeseValue <= 0) {
      cheeseValue = 0;
    } else {
      cheeseValue--;
    }
    notifyListeners();
  }

  minusBacon() {
    if (baconValue <= 0) {
      baconValue = 0;
    } else {
      baconValue--;
    }
    notifyListeners();
  }

  minusOnion() {
    if (onionValue <= 0) {
      onionValue = 0;
    } else {
      onionValue--;
    }
    notifyListeners();
  }

  selectSmallSize() {
    if (smallTapped == false && !largeTapped && !mediumTapped) {
      size = 'S';
      smallTapped = true;
    } else if (smallTapped == true) {
      size = '';
      smallTapped = false;
    }
    notifyListeners();
  }

  selectMediumSize() {
    if (mediumTapped == false && !smallTapped && !largeTapped) {
      size = 'M';
      mediumTapped = true;
    } else if (mediumTapped == true) {
      size = '';
      mediumTapped = false;
    }
    notifyListeners();
  }

  selectLargeSize() {
    if (largeTapped == false && !smallTapped && !mediumTapped) {
      size = 'L';
      largeTapped = true;

    } else if (largeTapped == true) {
      size = '';
      largeTapped = false;
    }
    notifyListeners();
  }

  removeAllData() {
    cheeseValue = 0;
    baconValue = 0;
    onionValue = 0;
    smallTapped = false;
    mediumTapped = false;
    largeTapped = false;
    notifyListeners();
  }

  addToCart(BuildContext context, dynamic data) async {
    if (smallTapped != false || mediumTapped != false || largeTapped != false) {
      cartData++;
      await Provider.of<ManageData>(context, listen: false)
          .submitData(context, data);
      notifyListeners();
    } else {
      return showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              color: Colors.black,
              height: 50,
              child: const Center(
                child: Text(
                  "Select Size !",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          });
    }
  }
}