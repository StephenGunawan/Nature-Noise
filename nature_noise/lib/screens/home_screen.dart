import 'package:flutter/material.dart';
import 'package:nature_noise/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //back button
        automaticallyImplyLeading: false,
        // Title
        title: Text("Nature noise",
          style: TextStyle(
            color: Colors.black,
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
              color: Colors.black,
              size: 50,
              )
            )
        )],
      ),
      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
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