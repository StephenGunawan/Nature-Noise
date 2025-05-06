import 'package:flutter/material.dart';
import 'package:nature_noise/custom_widgets/input_card.dart';
import 'package:nature_noise/screens/authentication/login.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( 
        children: [
          const Positioned(
          top: 110,
          right: 120,
          child: 
            Text("Nature Noise",
              style: TextStyle(
                fontSize: 27,
                fontFamily: 'Knewave'
              ),
            ),
          ),
          const Positioned(
            top: 200,
            right: 39,
            child: SizedBox(
              height:480,
              width: 329,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 25,
                      right: 117,
                      child: Text("SIGN UP",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 75,
                      right: 20,
                      child: InputCard(
                        initialText: "First name"
                      ),
                    ),
                    Positioned(
                      top: 135,
                      right: 20,
                      child: InputCard(
                        initialText: "Last name"
                      ),
                    ),
                    Positioned(
                      top: 195,
                      right: 20,
                      child: InputCard(
                        initialText: "User name"
                      ),
                    ),
                    Positioned(
                      top: 255,
                      right: 20,
                      child: InputCard(
                        initialText: "Email"
                      ),
                    ),
                    Positioned(
                      top: 315,
                      right: 20,
                      child: InputCard(
                        initialText: "Password"
                      ),
                    ),
                    Positioned(
                      top: 375,
                      right: 20,
                      child: InputCard(
                        initialText: "Confirm password"
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //Login Button
          Positioned(
            top: 700,
            right: 130,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 5,
                minimumSize: Size(150,45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
              }, 
              child: const Text("LOGIN",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          //Sign up button
          Positioned(
            top: 760,
            right: 130,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 5,
                minimumSize: Size(150,45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
              }, 
              child: const Text("SIGN UP",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}