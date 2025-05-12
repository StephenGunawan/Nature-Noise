import 'package:flutter/material.dart';
import 'package:nature_noise/custom_widgets/custom_button.dart';
import 'package:nature_noise/custom_widgets/input_card.dart';
import 'package:nature_noise/screens/authentication/sign_up.dart';
import 'package:nature_noise/screens/home_screen.dart';
import 'package:nature_noise/state_management/authentication_state.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
   const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController =TextEditingController();

  void login() async{
    await Provider.of<AuthenticationState>(context, listen: false).login(
      email: emailController.text, 
      password: passwordController.text);
    if (Provider.of<AuthenticationState>(context, listen: false).error == null){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }
  }

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
              child: SizedBox(
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
                      if(Provider.of<AuthenticationState>(context, listen: false).error!= null)
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                              Text(Provider.of<AuthenticationState>(context, listen: false).error!, 
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            )
                          ]
                        ),
                      ),
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
                login();
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