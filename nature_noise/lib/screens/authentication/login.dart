import 'package:flutter/material.dart';
import 'package:nature_noise/components/my_input.dart';
import 'package:nature_noise/components/my_login_button.dart';
import 'package:nature_noise/custom_widgets/custom_button.dart';
import 'package:nature_noise/custom_widgets/input_card.dart';
import 'package:nature_noise/screens/authentication/sign_up.dart';
import 'package:nature_noise/screens/home_screen.dart';

class Login extends StatefulWidget {
   Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController =TextEditingController();

  // Prevent from memory
  // @override
  // void dispose() {
  //   emailController.dispose();
  //   passwrodController.dispose();
  //   super.dispose();
  // }
  // BUILD UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column( 
          children: [
            SizedBox(height: 70),
            Text("Nature Noise",
              style: TextStyle(
                fontSize: 27,
                fontFamily: 'Knewave'
              ),
            ),
            SizedBox(height: 50),
            Center(
              child: Container(
                width: 329,
                height: 230,
                child: Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text("LOGIN",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      InputCard(
                        initialText: "Email",
                        textEditingController: emailController, 
                        isSecure: false),
                      SizedBox(height: 5),
                      InputCard(
                        initialText: "Password",
                        textEditingController: passwordController, 
                        isSecure: true),
                    ]
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            //Login Button
            CustomButton(
              width: 150, 
              height: 45, 
              text: "LOGIN", 
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()
                ));
              }
            ),
            SizedBox(height: 10,),
            //Sign up button
            CustomButton(
              width: 150, 
              height: 45, 
              text: "SIGN UP", 
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()
                ));
              }
            ),
          ],     
        ),
      ),
    );
  }
}