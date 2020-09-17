import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/admin/orderscreen.dart';
import 'manage_product.dart';
import 'file:///C:/Users/lapshop/ecommerce/lib/screens/admin/addproducts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class AdminHome extends StatelessWidget {
  static String routeName = 'AdminHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body : SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            color: Colors.black,
            child: Text('Add Products' ,
               style: TextStyle(
              color:kMainColor,
                 fontWeight: FontWeight.bold,
               ),),
            onPressed: (){
              Navigator.pushNamed(context, AddProducts.routeName);
            },
          ),
          ////////
          RaisedButton(
            color: Colors.black,
            child: Text('Edit Products',
               style: TextStyle(
              color:kMainColor,
                 fontWeight: FontWeight.bold,

               ),),
            onPressed: (){
              Navigator.pushNamed(context, ManageProduct.routeName);
            },
          ),
          /////
          RaisedButton(
            color: Colors.black,
            child: Text(' View  Orders ' , style: TextStyle(
              color:kMainColor,
              fontWeight: FontWeight.bold,
            ),
            ),
            onPressed: (){
              Navigator.pushNamed(context, OrdersScreen.routeName);

            },
          ),
        ],
      ),
    ),
    );
  }
}
