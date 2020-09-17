import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/screens/admin/edit_product.dart';
import 'package:ecommerce/screens/user/product_info.dart';
import 'package:ecommerce/services/store.dart';
import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  static String routeName = 'UserHome';
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  int _tabBarIndex = 0;
  final _store = Store();
  int _bootomValIndex =0;
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
            length: 4,
            child: Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                fixedColor: kMainColor,
                currentIndex: _bootomValIndex,
                type: BottomNavigationBarType.shifting,
                unselectedItemColor: Colors.black,
                onTap: (value){
setState(() {
  _bootomValIndex = value;

});                },
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.add),title: Text('Add'),),
                  BottomNavigationBarItem(icon: Icon(Icons.person),title: Text('customers'),),
                  BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),title: Text('shop'),),
                  BottomNavigationBarItem(icon: Icon(Icons.access_alarms),title: Text('time'),),
                ],
              ),
               appBar: AppBar(
                 elevation: 0,
                 backgroundColor: kMainColor,
                  bottom: TabBar(
                    indicatorColor: Colors.black,
                    onTap: (value){
                      setState(() {
                        _tabBarIndex = value;
                      });
                    },
                   tabs: <Widget>[
                    Text('jackets' ,
                    style: TextStyle(
                      color: _tabBarIndex ==0 ? Colors.black : Colors.white,
                      fontSize: _tabBarIndex ==0 ? 17 : null,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    Text('trousers',
                      style: TextStyle(
                        color: _tabBarIndex ==1 ? Colors.black : Colors.white,
                        fontSize: _tabBarIndex ==1? 16 : null,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                    Text('t-shirts',
                      style: TextStyle(
                        color: _tabBarIndex ==2 ? Colors.black : Colors.white,
                        fontSize: _tabBarIndex ==2 ? 16 : null,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                    Text('shoes' ,
                      style: TextStyle(
                        color: _tabBarIndex ==3 ? Colors.black : Colors.white,
                        fontSize: _tabBarIndex ==3 ? 18 : null,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                ]
            ),
          ),
         body: TabBarView(
             children:<Widget>[
                jacketView(),
                trouserView(),
               tshirtView(),
               shoseView(),



             ]),
        )),
       Material(
         child: Container(
             color: kMainColor,
               height: MediaQuery.of(context).size.height*.15,
               child:Padding(
                   padding:EdgeInsets.fromLTRB(20, 30, 20, 0),
                   child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   Text('Discover' .toUpperCase() ,
                     style: TextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                   Icon(Icons.shopping_cart),
                 ],
               ),
           ),
         ),
       )


      ],
    );
  }

  Widget jacketView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.loadProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product> products = [];
          for (var doc in snapshot.data.documents) {
            var data = doc.data;
            if (doc.data[kProductCategory] == kJackets) {
              products.add(Product(
                  pId: doc.documentID,
                  pPrice: data[kProductPrice],
                  pName: data[kProductName],
                  pDescription: data[kProductDescription],
                  pLocation: data[kProductLocation],
                  pCategory: data[kProductCategory]));
            }
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
            ),
            itemBuilder: (context , index)=> Padding(
              padding: EdgeInsets.symmetric(horizontal: 10 , vertical:10),
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, ProductInfo.routeName , arguments: products[index]);
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
    );
  }
   Widget trouserView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.loadProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product> products = [];
          for (var doc in snapshot.data.documents) {
            var data = doc.data;
            if (data[kProductCategory] == kTrousers) {
              products.add(Product(
                  pId: doc.documentID,
                  pPrice: data[kProductPrice],
                  pName: data[kProductName],
                  pDescription: data[kProductDescription],
                  pLocation: data[kProductLocation],
                  pCategory: data[kProductCategory]));
            }
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
            ),
            itemBuilder: (context , index)=> Padding(
              padding: EdgeInsets.symmetric(horizontal: 10 , vertical:10),
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, ProductInfo.routeName , arguments: products[index]);
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
    );
  }
  Widget tshirtView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.loadProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product> products = [];
          for (var doc in snapshot.data.documents) {
            var data = doc.data;
            if (data[kProductCategory] == kTshirts) {
              products.add(Product(
                  pId: doc.documentID,
                  pPrice: data[kProductPrice],
                  pName: data[kProductName],
                  pDescription: data[kProductDescription],
                  pLocation: data[kProductLocation],
                  pCategory: data[kProductCategory]));
            }
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
            ),
            itemBuilder: (context , index)=> Padding(
              padding: EdgeInsets.symmetric(horizontal: 10 , vertical:10),
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, ProductInfo.routeName , arguments: products[index]);
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
    );
  }
  Widget shoseView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.loadProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product> products = [];
          for (var doc in snapshot.data.documents) {
            var data = doc.data;
            if (data[kProductCategory] == kShoes) {
              products.add(Product(
                  pId: doc.documentID,
                  pPrice: data[kProductPrice],
                  pName: data[kProductName],
                  pDescription: data[kProductDescription],
                  pLocation: data[kProductLocation],
                  pCategory: data[kProductCategory]));
            }
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
            ),
            itemBuilder: (context , index)=> Padding(
              padding: EdgeInsets.symmetric(horizontal: 10 , vertical:10),
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, ProductInfo.routeName , arguments: products[index]);
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
    );
  }





}





