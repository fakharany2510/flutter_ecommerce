import 'package:ecommerce/provider/adminmode.dart';
import 'package:ecommerce/provider/modelhud.dart';
import 'file:///C:/Users/lapshop/ecommerce/lib/screens/admin/addproducts.dart';
import 'package:ecommerce/screens/admin/adminhome.dart';
import 'package:ecommerce/screens/admin/edit_product.dart';
import 'package:ecommerce/screens/admin/manage_product.dart';
import 'package:ecommerce/screens/admin/orderdetails.dart';
import 'package:ecommerce/screens/admin/orderscreen.dart';
import 'package:ecommerce/screens/login_screen.dart';
import 'package:ecommerce/screens/signup.dart';
import 'package:ecommerce/screens/user/cartscreen.dart';
import 'package:ecommerce/screens/user/product_info.dart';
import 'package:ecommerce/screens/user/userhome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
    ChangeNotifierProvider<ModelHud>(
    create: (context)=>ModelHud()),
    ChangeNotifierProvider<AdminMode>(
      create: (context)=>AdminMode(),
    ),
      ],
      child:MaterialApp(
      debugShowCheckedModeBanner: false,
      //the first screen app will go to
      initialRoute: LoginScreen.routeName,
      //routes of the app
      routes: {
        LoginScreen.routeName:(context)=>LoginScreen(),
        SignUp.routeName:(context)=>SignUp(),
        AdminHome.routeName:(ctx)=>AdminHome(),
        UserHome.routeName:(ctx)=>UserHome(),
        AddProducts.routeName:(ctx)=>AddProducts(),
        ManageProduct.routeName:(ctx)=>ManageProduct(),
        EditProduct.routeName:(ctx)=>EditProduct(),
        ProductInfo.routeName:(ctx)=>ProductInfo(),
        OrderDetails.routeName: (context) => OrderDetails(),
        OrdersScreen.routeName: (context) => OrdersScreen(),
        CartScreen.routeName: (context) => CartScreen(),
      },
      ),
    );
  }
}
