import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/constants.dart';
////Very Important////////////////////////////////////////
class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;
  CustomTextField({@required this.onClick , @required this.icon ,@required this.hint});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        validator: (value){
          if(value.isEmpty){
            return 'Please enter $hint ';
          }
          return null;
        },
        onSaved: onClick,
        obscureText: hint == 'Enter your Password' ? true : false ,
        cursorColor: kMainColor,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              //fontFamily: 'Permanent Marker',
              fontSize:15
            ),
            prefixIcon: Icon(icon,
                color: kMainColor ),
            filled: true,
            fillColor:kSecondaryColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  color:Colors.white
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  color:Colors.white
              ),
            ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
                color:Colors.red
            ),
        ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
          color:Colors.red
      ),
    )
      ),
    ),
    );
  }
}

