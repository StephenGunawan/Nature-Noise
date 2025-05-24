import 'package:flutter/material.dart';
import 'package:nature_noise/custom_widgets/temp_replay.dart';
import 'package:nature_noise/screens/home_screen.dart';
import 'package:nature_noise/screens/library_screen.dart';
import 'package:nature_noise/screens/profile_screen.dart';
import 'package:nature_noise/screens/sound_record_screen.dart';

class PromptScreen extends StatefulWidget {
  final String url;
  final String soundname;
  final String prompt;
  const PromptScreen({
    super.key,
    required this.url,
    required this.soundname,
    required this.prompt,
    });

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  int curIndex = 0;
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
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40),
            TempReplay(url: widget.url),
            SizedBox(height: 40),
            SizedBox(
              width: 350,
              height: 55,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                color: Color(0xFFFFDB02),
                child: Padding(
                  padding: const EdgeInsets.only(top: 14, left: 10),
                  child: Text(widget.soundname),
                ),
              ),
            ),     
            SizedBox(
              width: 350,
              height: 250,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                color: Color(0xFFFFDB02),
                child: Padding(
                  padding: const EdgeInsets.only(top: 14, left: 10),
                  child: Text(widget.prompt),
                )
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          if(index == 0){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
          }else if (index == 2){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SoundRecord()));
          }else if (index == 3){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LibraryScreen()));
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