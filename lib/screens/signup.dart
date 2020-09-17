import 'package:ecommerce/custom_widgets/custom_text_fiels.dart';
import 'package:ecommerce/provider/modelhud.dart';
import 'package:ecommerce/screens/login_screen.dart';
import 'package:ecommerce/screens/user/userhome.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
class SignUp extends StatelessWidget {
  final _formKey=GlobalKey<FormState>();
  static  String routeName ='SignUp';
  String _email , _password ;
  final _auth=Authentication();
  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    return ModalProgressHUD(
      inAsyncCall: Provider.of<ModelHud>(context).isLoading,
      child: Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: kMainColor,
          body: ListView(
            children: <Widget>[
              Padding(
                padding:EdgeInsets.only(top:10),
                child:Container(
                    height:MediaQuery.of(context).size.height *.2,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Image(
                          image:AssetImage("assets/icons/buy2.png"),
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
              SizedBox(height: height*.09,),
              CustomTextField(
                hint: 'Enter your name',
                icon: Icons.person,
              ),
              SizedBox(height: height*.02,),
              CustomTextField(
                onClick: (value){
                  _email=value;
                },
                hint: 'Enter your e-mail',
                icon: Icons.markunread,
              ),
              SizedBox(height: height*.02,),
              CustomTextField(
                onClick: (value){
                  _password=value;
                },
                hint: 'Enter your Password',
                icon: Icons.lock,
              ),
              SizedBox(height: height*.05,),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 120),
                  child:  Builder(
                      builder:(context)=> FlatButton(
                        color: Colors.black,
                        onPressed: ()async
                        {
                          final modelHud=
                              Provider.of<ModelHud>(context , listen: false);
                          modelHud.changeIsLoading(true);
                          if(_formKey.currentState.validate()){
                            _formKey.currentState.save();
                            try{
                              final authResult = await _auth.signIn(_email, _password);
                              modelHud.changeIsLoading(false);
                              Navigator.pushNamed(context, UserHome.routeName);
                            }
                            catch(e){
                              modelHud.changeIsLoading(false);
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content:Text(
                                      e.message
                                  )
                              ));
                            }
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'signup',
                          style: TextStyle(
                            color: Colors.white,
                            //fontFamily: 'Permanent Marker',
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
                  Text('have an account ? ',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        // fontFamily: 'Permanent Marker',
                        fontWeight: FontWeight.bold
                    ),),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    },
                    child:Text('login ',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          //fontFamily: 'Permanent Marker',
                          fontWeight: FontWeight.bold
                      ),),
                  )
                ],
              )

            ],
          ),
        ),
      )
    )
    ;
  }
}


