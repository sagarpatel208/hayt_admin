import 'package:flutter/material.dart';
import 'package:hayt_admin/Common/Constants.dart' as cnst;
import 'package:hayt_admin/Screens/AddCategory.dart';
import 'package:hayt_admin/Screens/ApproveFeeds.dart';
import 'package:hayt_admin/Screens/ApproveProducts.dart';
import 'package:hayt_admin/Screens/ApproveServices.dart';
import 'package:hayt_admin/Screens/ApproveShops.dart';
import 'package:hayt_admin/Screens/Category.dart';
import 'package:hayt_admin/Screens/Feeds.dart';
import 'package:hayt_admin/Screens/Login.dart';
import 'package:hayt_admin/Screens/Products.dart';
import 'package:hayt_admin/Screens/Services.dart';
import 'package:hayt_admin/Screens/Shops.dart';
import 'package:hayt_admin/Screens/VIP.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "HAYT Admin",
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/VIP': (context) => VIP(),
        '/Shops': (context) => Shops(),
        '/ApproveServices': (context) => ApproveServices(),
        '/Category': (context) => Category(),
        '/ApproveShops': (context) => ApproveShops(),
        '/AddCategory': (context) => AddCategory(),
        '/Products': (context) => Products(),
        '/Services': (context) => Services(),
        '/ApproveProducts': (context) => ApproveProducts(),
        '/ApproveFeeds': (context) => ApproveFeeds(),
        '/Feeds': (context) => Feeds(),
      },
      theme: ThemeData(
          fontFamily: 'Montserrat',
          primarySwatch: cnst.appPrimaryMaterialColor,
          accentColor: cnst.appPrimaryMaterialColor,
          buttonColor: cnst.appPrimaryMaterialColor),
    );
  }
}
