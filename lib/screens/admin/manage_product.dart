import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/custom_widgets/mypop_up_menu.dart';
import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/screens/admin/addproducts.dart';
import 'package:ecommerce/services/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'edit_product.dart';
class ManageProduct extends StatefulWidget {
  static String routeName='ManageProduct';

  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  @override
  final _store = Store();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Available Products'),
        centerTitle: true,
        backgroundColor: kMainColor,
        elevation: 1,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              products.add(Product(
                  pId          : doc.documentID,
                  pPrice       : data[kProductPrice],
                  pName        : data[kProductName],
                  pDescription : data[kProductDescription],
                  pLocation    : data[kProductLocation],
                  pCategory    : data[kProductCategory]));
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              itemBuilder: (context , index)=> Padding(
                padding: EdgeInsets.symmetric(horizontal: 10 , vertical:10),
                child: GestureDetector(
                  onTapUp: (details){
                    double left = details.globalPosition.dx;
                    double top = details.globalPosition.dy;
                    double right = MediaQuery.of(context).size.width-left;
                    double buttom = MediaQuery.of(context).size.width-top;
                    showMenu(context: context,
                      position: RelativeRect.fromLTRB(left,top,right,buttom),
                    items: [
                      MyPopupMenuItem(
                        child: Text('Edit'),
                        onClick:(){
                          Navigator.pushNamed(context, EditProduct.routeName , arguments: products[index]);
                        },
                      ),
                      MyPopupMenuItem(
                        child: Text('Delete'),
                        onClick:(){
                          _store.deleteDocument(products[index].pId);
                          Navigator.pop(context);
                        },

                      ),

                    ]
                    );
                  },
                  child:Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage(products[index].pLocation),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: 0.6,
                          child: Container(
                            width:MediaQuery.of(context).size.width,
                            height:60,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(products[index].pName,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                    ),),
                                  Text(products[index].pPrice,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              itemCount: products.length,
            );
          } else {
            return Center(child: Text('Loading...'));
          }
        },
      ),
    );
  }
}