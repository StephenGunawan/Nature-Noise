import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nature_noise/custom_widgets/custom_button.dart';
import 'package:nature_noise/models/user_model.dart';
import 'package:nature_noise/screens/authentication/signup_login.dart';
import 'package:nature_noise/state_management/authentication_state.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  void signOut () async{
    await Provider.of<AuthenticationState>(context, listen: false).signOut();
    if(!mounted){
      return;
    }
    if (Provider.of<AuthenticationState>(context, listen: false).signOutError == null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignupLogin()));
    }
  }
  //extract user data for username, firstname, lastname, and email
  Future<UserData> extractUserData() async{
    try {
      DocumentSnapshot data = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
      return UserData.fromJson(data.data() as Map<String, dynamic>);
    }catch(e){
      throw Exception("error user data extraction");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Title
        centerTitle: true,
        title: Text("Nature noise",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Knewave',
            fontSize: 27,
          ),
        ),
      ),
      body: FutureBuilder <UserData>(
        future: extractUserData(), 
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          if (snapshot.hasError || !snapshot.hasData){
            return Text("error on user data extraction");
          }
          final user = snapshot.data!;

          return Center(
            child:Column(
              children: [
                SizedBox(height: 50),
                Icon(
                  Icons.account_circle,
                  size: 150,
                  ),
                Text(user.userName, style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 10),
                Text("${user.firstName} ${user.lastName}", style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: 350,
                  child: Card(
                    elevation: 5, 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      color: Theme.of(context).colorScheme.onPrimary,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(user.email, style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                      ),
                  ),
                ),
                SizedBox(height:50),
                CustomButton(
                  width: 150, 
                  height: 45,  
                  text: "SIGN OUT", 
                  onPressed: signOut
                ),
                //if error occurs for signout
                if(Provider.of<AuthenticationState>(context, listen: false).signOutError!= null)
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.close,
                              color: Colors.red,
                              ),
                          Text(Provider.of<AuthenticationState>(context, listen: false).signOutError!, 
                            style: TextStyle(
                              color: Colors.red,
                        ),
                       )
                    ]
                  ),
                ),
              ]
            ),
          );
        }
      )
    );
  }
}