import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nature_noise/models/user_model.dart';


class AuthenticationState extends ChangeNotifier {
  bool isSignedin = false;
  String? error;

  // ensures that sign in status is called right away
  AuthenticationState(){
    signInStatus();
  }

  //Update usersigned in status do user don't have to log back in
  void signInStatus(){
    FirebaseAuth.instance.authStateChanges().listen((User? user){
      if (user == null){
        isSignedin  = false;
        notifyListeners();
      }else{
        isSignedin = true;
        notifyListeners();
      }
    });
  }
  
  // User signup method
  Future <void> signUp({
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
    required String password,
    required String confirmPassword
  }) async{
      if (
        firstName.isEmpty ||
        lastName.isEmpty ||
        userName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty
        ){
        error = "missing input";
        notifyListeners();
      }else if(password!=confirmPassword){
        error = "Passwords needs to match";
        notifyListeners();
      }else{
        try {
          UserCredential? authentication = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email, 
            password: password);
          error = null;

          if (authentication.user != null){
            UserData data = UserData(
              firstName: firstName,
              lastName: lastName,
              userName: userName,
              email: email,
              uid: authentication.user!.uid
            );
            await FirebaseFirestore.instance.collection('users').doc(data.uid).set(data.toJson());
          }
          notifyListeners();
        } on FirebaseAuthException catch(e){
          error = e.code;
          notifyListeners();
        }
      }
    }
  
  //user login method
  Future <void> login({
  required String email,
  required String password,
  }) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, 
        password: password);
        notifyListeners();
    } on FirebaseAuthException catch (e){
        error = e.code;
        notifyListeners();
    }
  }

  Future <void> signOut() async {
    try{
      await FirebaseAuth.instance.signOut(); 
      notifyListeners();
    }on FirebaseAuthException catch (e){
      error = e.code;
      notifyListeners();
    }
  } 
}
