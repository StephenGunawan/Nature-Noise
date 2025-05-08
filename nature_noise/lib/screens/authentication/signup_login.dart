import 'package:flutter/material.dart';
import 'package:nature_noise/custom_widgets/custom_button.dart';
import 'package:nature_noise/screens/authentication/login.dart';
import 'package:nature_noise/screens/authentication/sign_up.dart';

class SignupLogin extends StatelessWidget {
  const SignupLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column( 
            children: [ 
              SizedBox(height: 200,),
              Text("Nature Noise",
                style: TextStyle(
                  fontSize: 48,
                  fontFamily: 'Knewave'
                ),
              ),
              //Login Button
              SizedBox(height: 130,),
              CustomButton(
                width: 150, 
                height: 45, 
                text: "LOGIN", 
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()
                  ));
                }
              ),
              //Sign up button
              SizedBox(height: 10,),
              CustomButton(
                width: 150, 
                height: 45, 
                text: "SIGN UP", 
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()
                  ));
                }
              ),
            ]
          ),
        ),
      ),
    );
  }
}