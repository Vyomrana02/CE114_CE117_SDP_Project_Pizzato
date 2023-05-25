import 'package:ce114_ce117_sdp_project/AdminPanel/Services/AdminDetailHelpers.dart';
import 'package:ce114_ce117_sdp_project/AdminPanel/Services/DeliveryOptions.dart';
import 'package:ce114_ce117_sdp_project/Helpers/Middle.dart';
import 'package:ce114_ce117_sdp_project/Provider/Authentication.dart';
import 'package:ce114_ce117_sdp_project/Provider/Calculations.dart';
import 'package:ce114_ce117_sdp_project/Provider/Payment.dart';
import 'package:ce114_ce117_sdp_project/Services/ManageData.dart';
import 'package:ce114_ce117_sdp_project/Services/ManageMaps.dart';
import 'package:ce114_ce117_sdp_project/Views/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ce114_ce117_sdp_project/Helpers/Headers.dart';
import 'Helpers/Footers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Headers()),
        ChangeNotifierProvider.value(value: MiddleHelpers()),
        ChangeNotifierProvider.value(value: ManageData()),
        ChangeNotifierProvider.value(value: Footers()),
        ChangeNotifierProvider.value(value: GenerateMaps()),
        ChangeNotifierProvider.value(value: Authentication()),
        ChangeNotifierProvider.value(value: Calculations()),
        ChangeNotifierProvider.value(value: PaymentHelper()),
        ChangeNotifierProvider.value(value: AdminDetailHelper()),
        ChangeNotifierProvider.value(value: DeliveryOptions()),
      ],
      child: MaterialApp(
          title: 'Pizzato',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            canvasColor: Colors.transparent,
            primarySwatch: Colors.red,
            primaryColor: Colors.redAccent,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Splashscreen()),
    );
  }
}