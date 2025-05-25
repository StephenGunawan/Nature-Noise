import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nature_noise/state_management/authentication_state.dart';

// unit test authentication state management
void main(){
  late MockFirebaseAuth mockAuth;
  late FakeFirebaseFirestore fakeFirestore;
  late AuthenticationState authState;

  // set up mock environment
  setUp((){
    mockAuth = MockFirebaseAuth();
    fakeFirestore = FakeFirebaseFirestore();

    authState = AuthenticationState(
      firebaseAuth: mockAuth,
      firebaseFirestore: fakeFirestore,
    );
  });
  test("isSignedin equal to false at the start", (){
    expect(authState.isSignedin, false);
  });

  test("missing inputs tests for sign up", ()async{
    await authState.signUp(
      firstName: "Mark", 
      lastName: "Leaf", 
      userName: "Mark_77", 
      email: "", 
      password: "123456789", 
      confirmPassword: "123456789"
      );
    expect(authState.waiting, false);
    expect(authState.signUpError, "missing input");
  });

  test("non matching password for sign up", ()async{
    await authState.signUp(
      firstName: "Mark", 
      lastName: "Leaf", 
      userName: "Mark_77", 
      email: "mark@gmail.com", 
      password: "123456789", 
      confirmPassword: "abcdefg"
      );
    expect(authState.waiting, false);
    expect(authState.signUpError, "Passwords needs to match");
  });

  test("successful sign up", ()async{
    await authState.signUp(
      firstName: "Mark", 
      lastName: "Leaf", 
      userName: "Mark_77", 
      email: "mark@gmail.com", 
      password: "123456789", 
      confirmPassword: "123456789"
      );
    expect(authState.waiting, false);
    expect(authState.signUpError, null);

    var usersTest = await fakeFirestore.collection('users').get();
    expect(usersTest.docs.length, 1);
    expect(usersTest.docs[0].data()['first_name'], "Mark");
  });

  test("successful login", ()async{
    await authState.login(
      email: "mark@gmail.com", 
      password: "123456789", 
      );
    expect(authState.waiting, false);
    expect(authState.loginError, null);
  });

  test("test sign out success", ()async{
    mockAuth = MockFirebaseAuth();
    await mockAuth.signInWithEmailAndPassword(
      email: "test@gmail.com", 
      password: "123456789"
      );
    authState = AuthenticationState(
      firebaseAuth: mockAuth,
      firebaseFirestore: fakeFirestore,
    );

    //need to wait to listen to the current user
    await Future.delayed(Duration(milliseconds: 100));
    expect(authState.isSignedin, true);
    await authState.signOut();
    expect(authState.waiting, false);
    expect(authState.signOutError, null);
    expect(authState.isSignedin, false);
  });

  test("test clear error", ()async{
    authState.loginError = "wrong password";
    authState.signUpError = "missing input";
    authState.signOutError = "unable to signout user";
    authState.clearError();
    expect(authState.loginError, null);
    expect(authState.signUpError, null);
    expect(authState.signOutError, null);
  });
}