import 'package:flutter/material.dart';
import 'package:nature_noise/screens/profile_screen.dart';
import 'package:nature_noise/screens/sound_record_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int curIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //back button
        automaticallyImplyLeading: false,
        // Title
        centerTitle: true,
        title: Text("Nature noise",
          style: TextStyle(
            fontFamily: 'Knewave',
            fontSize: 27,
          ),
        ),
        // Icon
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
      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          if (index == 2){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SoundRecord()));
          }else{
            setState(() {
              curIndex = index;
            });
          }
        },
        currentIndex: curIndex,
        type: BottomNavigationBarType.fixed,
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 50),
            label: ''
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, size: 50),
            label: ''
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mic, size: 50),
            label: ''
            
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book, size: 50),
            label: ''
            ),
        ]
      ),
    );
  }
}