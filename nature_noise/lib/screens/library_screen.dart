import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nature_noise/custom_widgets/post_save_replay.dart';
import 'package:nature_noise/screens/home_screen.dart';
import 'package:nature_noise/screens/profile_screen.dart';
import 'package:nature_noise/screens/sound_record_screen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int curIndex = 0;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Column(
        children: [
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("Library",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,),
              ),
            ),
          ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
                  .collection("userNatureNoiseRecordings")
                  .where('uid', isEqualTo: userID)
                  .orderBy('created_time', descending: true)
                  .snapshots(), 
          builder: (context, snapshot){
            if (snapshot.hasError){
              return Center(child: Text("Error loading posts"));
            }
            if (!snapshot.hasData){
              return Center(child: CircularProgressIndicator(
                color: Colors.black,
              ));
            }
            final docs = snapshot.data!.docs;
            if(docs.isEmpty){
              return Center(child: Text("Users have not posted"));
            }
            return Center(
              child: SizedBox(
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (_, i){
                      final m = docs[i].data() as Map<String, dynamic>;
                      return SizedBox(
                        height: 240,
                        child: PostSaveReplay(
                          url: m['sound_URL'] , 
                          username: m['username'] , 
                          soundname: m['sound_name'],
                          prompt: m['prompt'] ?? "",
                        ),
                      );
                    }
                  ),
                ),
              ),
            );
          }
          ),
        ),
        ],
      ),
      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          if(index == 0){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
          }else if (index == 2){
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