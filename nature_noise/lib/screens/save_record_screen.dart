import 'package:flutter/material.dart';
import 'package:nature_noise/custom_widgets/temp_replay.dart';
import 'package:nature_noise/screens/profile_screen.dart';

class SaveRecord extends StatefulWidget {
  final String url;
  const SaveRecord ({super.key, required this.url});

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

      body: Column(
        children: [
          TempReplay(url: widget.url)
        ],
      )
    );
  }
}