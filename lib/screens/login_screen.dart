import 'package:ecommerce/custom_widgets/custom_text_fiels.dart';
import 'package:ecommerce/provider/adminmode.dart';
import 'package:ecommerce/provider/modelhud.dart';
import 'package:ecommerce/screens/admin/adminhome.dart';
import 'package:ecommerce/screens/signup.dart';
import 'package:ecommerce/screens/user/userhome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'package:ecommerce/services/auth.dart';
class LoginScreen extends StatefulWidget {
  static String routeName='Loginscreen';
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  String _email  , _password;
  final _auth = Authentication();
  final adminPassword='Admin1234';
  @override

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body:Form(
        key: widget.globalKey ,
        child:ListView(
          children: <Widget>[
            Padding(
              padding:EdgeInsets.only(top:40),
              child:Container(
                  height:MediaQuery.of(context).size.height *.2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Image(
                        image:AssetImage("assets/icons/buy.png"),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Text('Buy it' ,
                          style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontSize: 25,
                          ),),

                      )
                    ],
                  )
              ),
            ),
            SizedBox(height: height*.1,),
            CustomTextField(
              onClick: (value){
                _email = value;
              },
              hint: 'Enter your e-mail',
              icon: Icons.markunread,
            ),
            SizedBox(height: height*.02,),
            CustomTextField(
              onClick: (value){
                _password = value;
              },
              hint: 'Enter your Password',
              icon: Icons.lock,
            ),
            SizedBox(height: height*.05,),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 120),
                child:Builder(
                  builder:(context)=> FlatButton(
                    color: Colors.black,
                    onPressed: ()async{
                      _validate(context);
                      /*if(_formKey.currentState.validate()){
                        _formKey.currentState.save();
                        try {
                          final result = await _auth.logIn(_email, _password);
                          print(result.user.email);
                          Navigator.pushNamed(context, SignUp.routeName);
                        }
                        catch(e){
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content:Text(
                                  e.message
                              )
                          ));
                        }
                      }*/
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'login',
                      style: TextStyle(
                        color: Colors.white,
                        //  fontFamily: 'Permanent Marker',
                        fontSize: 18,
                      ),
                    ),
                  )
                )

            ),
            SizedBox(height: height*.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Don\'t have account ? ',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                     // fontFamily: 'Permanent Marker',
                      fontWeight: FontWeight.bold
                  ),),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, SignUp.routeName);
                  },
                  child:Text('signup ',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        //fontFamily: 'Permanent Marker',
                        fontWeight: FontWeight.bold
                    ),),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30 , vertical: 10),
              child:Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap:(){
                        Provider.of<AdminMode>(context , listen: false).changeIsAdmin(true);
                      },
                      child: Text('Iam an admin' ,
                        style: TextStyle(
                          color: Provider.of<AdminMode>(context).isAdmin
                              ? kMainColor : Colors.white,
                        ),),


                    ),

                  ),
                  Expanded(
                    child:  GestureDetector(
                      onTap: (){
                        Provider.of<AdminMode>(context , listen: false).changeIsAdmin(false);
                      },
                      child: Text('Iam a user',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Provider.of<AdminMode>(context).isAdmin
                              ? Colors.white  : kMainColor ,
                        ),
                      ),

                    ),
                  ),
                ],
              ),
            ),

          ],
        ),

      )
    );
  }
  void _validate(BuildContext context) async {
    final modelhud = Provider.of<ModelHud>(context, listen: false);
    modelhud.changeIsLoading(true);
    if (widget.globalKey.currentState.validate()) {
      widget.globalKey.currentState.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (_password == adminPassword) {
          try {
            await _auth.logIn(_email.trim(), _password.trim());
            Navigator.pushNamed(context, AdminHome.routeName);
          }
          catch(e){
            modelhud.changeIsLoading(false);
            Scaffold.of(context).showSnackBar(SnackBar(
                content:Text(
                    e.message
                )
            ));
          }
        } else {
          modelhud.changeIsLoading(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Something went wrong !'),
          ));
        }
      } else {
        try {
          await _auth.logIn(_email.trim(), _password.trim());
          Navigator.pushNamed(context, UserHome.routeName);
        }
        catch(e){
          Scaffold.of(context).showSnackBar(SnackBar(
              content:Text(
                  e.message
              )
          ));
        }
      }
    }
    modelhud.changeIsLoading(false);
  }



}

