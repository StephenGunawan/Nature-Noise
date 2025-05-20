import 'package:flutter/material.dart';
import 'package:nature_noise/custom_widgets/custom_button.dart';
import 'package:nature_noise/custom_widgets/input_card.dart';
import 'package:nature_noise/screens/authentication/login.dart';
import 'package:nature_noise/state_management/authentication_state.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController =TextEditingController();
  final TextEditingController userNameController =TextEditingController();
  final TextEditingController emailController =TextEditingController();
  final TextEditingController passwordController =TextEditingController();
  final TextEditingController confirmPasswordController =TextEditingController();

  void signUp() async{
      await Provider.of<AuthenticationState>(context, listen: false).signUp(
        firstName: firstNameController.text, 
        lastName: lastNameController.text, 
        userName: userNameController.text, 
        email: emailController.text, 
        password: passwordController.text, 
        confirmPassword: confirmPasswordController.text);
      if(!mounted){
        return;
      }
      if (Provider.of<AuthenticationState>(context, listen: false).error == null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
      }
    }
  
  // Prevent from memory leakage
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }


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
              child: SizedBox(
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
                        textEditingController: firstNameController,
                        isSecure: false,
                      ),
                      SizedBox(height: 5),
                      InputCard(
                        initialText: "Last name",
                        textEditingController: lastNameController,
                        isSecure: false,
                      ),
                      SizedBox(height: 5),
                      InputCard(
                        initialText: "User name",
                        textEditingController: userNameController,
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
                        textEditingController: passwordController,
                        isSecure: false,
                      ),
                      SizedBox(height: 5),
                      InputCard(
                        initialText: "Confirm password",
                        textEditingController: confirmPasswordController,
                        isSecure: false,
                      ),
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
                signUp();
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