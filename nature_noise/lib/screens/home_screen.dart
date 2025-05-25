import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nature_noise/custom_widgets/post_save_replay.dart';
import 'package:nature_noise/screens/library_screen.dart';
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
      //query result only for public posts 
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
                .collection("userNatureNoiseRecordings")
                .where('visible_all_users', isEqualTo: true)
                .orderBy('created_time', descending: true)
                .snapshots(), 
        builder: (context, snapshot){
          //if error occurs
          if (snapshot.hasError){
            return Center(child: Text("Error loading posts"));
          }
          //if loading posts 
          if (!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }
          //if there is no public posts
          final docs = snapshot.data!.docs;
          if(docs.isEmpty){
            return Center(child: Text("Users have not posted"));
          }
          //all users save recordings through ListView widget and custon PostSaveReplay widget
          return Center(
            child: SizedBox(
              width: 400,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
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
      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          if (index == 2){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SoundRecord()));
          }else if(index == 3){
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