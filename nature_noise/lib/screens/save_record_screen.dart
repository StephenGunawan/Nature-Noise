import 'package:flutter/material.dart';
import 'package:nature_noise/screens/profile_screen.dart';

class SaveRecord extends StatefulWidget {
  const SaveRecord ({super.key});

  @override
  State<SaveRecord> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SaveRecord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: IconButton(
            onPressed: ()=>Navigator.push(context, MaterialPageRoute(
              builder: (context)=>ProfileScreen())), 
            icon: Icon(
              Icons.account_circle,
              size: 50,
              )
            )
        )],
      ),
    );
  }
}