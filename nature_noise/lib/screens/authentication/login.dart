import 'package:flutter/material.dart';
import 'package:nature_noise/custom_widgets/input_card.dart';
import 'package:nature_noise/screens/authentication/sign_up.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( 
        children: [
          const Positioned(
          top: 135,
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
            top: 250,
            right: 39,
            child: SizedBox(
              height:235,
              width: 329,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 15,
                      right: 125,
                      child: Text("LOGIN",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 65,
                      right: 20,
                      child: InputCard(
                        initialText: "Email"
                      ),
                    ),
                    Positioned(
                      top: 130,
                      right: 20,
                      child: InputCard(
                        initialText: "Password"
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //Login Button
          Positioned(
            top: 550,
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
            top: 610,
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