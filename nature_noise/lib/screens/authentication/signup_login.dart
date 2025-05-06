import 'package:flutter/material.dart';

class SignupLogin extends StatelessWidget {
  const SignupLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( 
        children: [
          Positioned(
          top: 250,
          right: 60,
          child: 
            Text("Nature Noise",
              style: TextStyle(
                fontSize: 48,
                fontFamily: 'Knewave'
              ),
            ),
          ),
          Positioned(
            top: 500,
            right: 130,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 5,
                minimumSize: Size(150,45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: (){}, 
              child: Text("LOGIN",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: 560,
            right: 130,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 5,
                minimumSize: Size(150,45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: (){}, 
              child: Text("SIGNUP",
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