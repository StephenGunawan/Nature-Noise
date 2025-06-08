import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nature_noise/models/user_model.dart';


class AuthenticationState extends ChangeNotifier {
  final FirebaseAuth authentication;
  final FirebaseFirestore firestore;

  bool isSignedin = false;
  String? loginError;
  String? signUpError;
  String? signOutError;
  bool waiting = false;

  // ensures that sign in status is called right away
  AuthenticationState({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firebaseFirestore,
  }) : authentication = firebaseAuth ?? FirebaseAuth.instance,
        firestore = firebaseFirestore ?? FirebaseFirestore.instance{
    signInStatus();
  }

  //Update usersigned in status do user don't have to log back in
  void signInStatus(){
    authentication.authStateChanges().listen((User? user){
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
    signUpError = null;
    waiting = true;
    notifyListeners();
      if (
        firstName.isEmpty ||
        lastName.isEmpty ||
        userName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty
        ){
        signUpError = "missing input";
        waiting = false;
        notifyListeners();
      }else if(password!=confirmPassword){
        signUpError = "Passwords needs to match";
        waiting = false;
        notifyListeners();
      }else{
        try {
          UserCredential? auth = await authentication.createUserWithEmailAndPassword(
            email: email, 
            password: password);
          signUpError = null;

          if (auth.user != null){
            UserData data = UserData(
              firstName: firstName,
              lastName: lastName,
              userName: userName,
              email: email,
              uid: auth.user!.uid
            );
            await firestore.collection('users').doc(data.uid).set(data.toJson());
          }
          notifyListeners();
        } on FirebaseAuthException catch(e){
          signUpError = e.code;
          notifyListeners();
        }finally{
          waiting = false;
          notifyListeners();
        }
      }
    }
  
  //user login method
  Future <void> login({
  required String email,
  required String password,
  }) async{
    loginError = null;
    waiting = true;
    notifyListeners();
    try{
      await authentication.signInWithEmailAndPassword(
        email: email, 
        password: password);
        notifyListeners();
    } on FirebaseAuthException catch (e){
        loginError = e.code;
        notifyListeners();
    }finally{
      waiting = false;
      notifyListeners();
    }
  }

  // user signout method 
  Future <void> signOut() async {
    waiting = true;
    notifyListeners();
    try{
      await authentication.signOut(); 
      notifyListeners();
    }on FirebaseAuthException catch (e){
      signOutError = e.code;
      notifyListeners();
    }finally{
      waiting = false;
      notifyListeners();
    }
  } 

  //clear all error if there is no error
  void clearError(){
  loginError = null;
  signUpError = null;
  signOutError = null;
  notifyListeners();
}
}


