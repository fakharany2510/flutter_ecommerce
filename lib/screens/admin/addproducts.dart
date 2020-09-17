import 'package:ecommerce/constants.dart';
import 'package:ecommerce/custom_widgets/custom_text_fiels.dart';
import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/services/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class AddProducts extends StatelessWidget {
  static String routeName = 'AddProducts';
  String _name , _price , _description , _category , _imageLocation;
  final _store = Store();
  final GlobalKey<FormState> _globalKey = GlobalKey <FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body:Form(
        key: _globalKey,
        child:ListView(
          children: <Widget>[
            SizedBox(height:50),
            CustomTextField(
              hint: 'Product Name',
              onClick: (value){
                _name=value;
              },
            ),
            SizedBox(height:10),
            CustomTextField(
              hint: 'Product Price',
              onClick: (value){
                _price=value;
              },
            ),
            SizedBox(height:10),
            CustomTextField(
              hint: 'Product Description',
              onClick: (value){
                _description=value;
              },
            ),
            SizedBox(height:10),
            CustomTextField(
              hint: 'Product Category',
              onClick: (value){
                _category=value;
              },
            ),
            SizedBox(height:10),
            CustomTextField(
              hint: 'Product Location',
              onClick: (value){
                _imageLocation=value;
              },
            ),
            SizedBox(height:20),
            Padding(
              padding:EdgeInsets.all(50),
              child: RaisedButton(
                color: Colors.black,
                child: Text('Add Product' ,
                  style: TextStyle(
                    color:kMainColor,
                    fontWeight: FontWeight.bold,
                  ),),
                onPressed: (){
                  if(_globalKey.currentState.validate()){
                    _globalKey.currentState.save();
                    _store.addProduct(Product(
                        pName: _name ,
                        pPrice: _price ,
                        pCategory: _category ,
                        pDescription: _description ,
                        pLocation: _imageLocation
                    )
                    );
                  }
                },
              ),
            ),

          ],
        ),
      ),

    );
  }
}
