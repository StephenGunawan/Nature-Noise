import 'package:flutter/material.dart';
import 'package:nature_noise/custom_widgets/custom_button.dart';
import 'package:nature_noise/custom_widgets/input_card.dart';
import 'package:nature_noise/screens/authentication/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController =TextEditingController();
  final TextEditingController usernameController =TextEditingController();
  final TextEditingController emailController =TextEditingController();
  final TextEditingController passwrodController =TextEditingController();
  final TextEditingController confirmPasswordController =TextEditingController();
  // BUILD UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column( 
          children: [
            SizedBox(height: 35),
            Text("Nature Noise",
              style: TextStyle(
                fontSize: 27,
                fontFamily: 'Knewave',
              ),
            ),
            SizedBox(height: 45),
            Center(
              child: Container(
                height:455,
                width: 329,
                child: Card(
                  elevation: 5,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text("SIGN UP",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      InputCard(
                        initialText: "First name", 
                        textEditingController: firstnameController,
                        isSecure: false,
                      ),
                      SizedBox(height: 5),
                      InputCard(
                        initialText: "Last name",
                        textEditingController: lastnameController,
                        isSecure: false,
                      ),
                      SizedBox(height: 5),
                      InputCard(
                        initialText: "User name",
                        textEditingController: usernameController,
                        isSecure: false,
                      ),
                      SizedBox(height: 5),
                      InputCard(
                        initialText: "Email",
                        textEditingController: emailController,
                        isSecure: false,
                      ),
                      SizedBox(height: 5),
                      InputCard(
                        initialText: "Password",
                        textEditingController: passwrodController,
                        isSecure: false,
                      ),
                      SizedBox(height: 5),
                      InputCard(
                        initialText: "Confirm password",
                        textEditingController: confirmPasswordController,
                        isSecure: false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            //Login Button
            CustomButton(
              width: 150, 
              height: 45, 
              text: "SIGN UP", 
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()
                ));
              }
            ),
            SizedBox(height: 10,),
            //Sign up button
            CustomButton(
              width: 150, 
              height: 45, 
              text: "LOGIN", 
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()
                ));
              }
            ),
          ]
        ),
      ),
    );
  }
}