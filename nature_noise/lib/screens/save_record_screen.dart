import 'package:flutter/material.dart';
import 'package:nature_noise/custom_widgets/custom_button.dart';
import 'package:nature_noise/custom_widgets/temp_replay.dart';
import 'package:nature_noise/screens/home_screen.dart';
import 'package:nature_noise/screens/profile_screen.dart';
import 'package:nature_noise/state_management/sound_recording_state.dart';
import 'package:provider/provider.dart';

class SaveRecord extends StatefulWidget {
  final String url;
  const SaveRecord ({super.key, required this.url});

  @override
  State<SaveRecord> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SaveRecord> {
  final TextEditingController soundNameController = TextEditingController();
  final TextEditingController promptController =TextEditingController();

  @override
  void dispose() {
    soundNameController.dispose();
    promptController.dispose();
    super.dispose();
  }

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
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                color: Color(0xFFFFDB02),
                child: TextField(
                  controller: soundNameController,
                  decoration: InputDecoration(
                    border:InputBorder.none,
                    hintText: "Sound name",
                    contentPadding: EdgeInsets.only(left:7.0),
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 150),
                    ),
                  ),
                )
              ),
            ),
            Consumer<SoundRecordingState>(
              builder: (context, state, _){
                if(state.errorSaveSound!=null){
                  return Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Row(
                      children: [
                      Icon(
                        Icons.close,
                          color: Colors.red,
                          ),
                        Text(state.errorSaveSound!, 
                        style: TextStyle(
                                  color: Colors.red,
                            ),
                          )
                        ]
                    ),
                  );
                }else{
                  return SizedBox.shrink();
                }
              }
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
                child: TextField(
                  controller: promptController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border:InputBorder.none,
                    hintText: "Prompt",
                    contentPadding: EdgeInsets.only(left:7.0),
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 150),
                    ),
                  ),
                )
              ),
            ),
            SizedBox(height: 20),
            CustomButton(
              width: 150, 
              height: 50, 
              text: "Save and Post", 
              onPressed: ()async{
                final soundSave = context.read<SoundRecordingState>();

                await soundSave.uploadMetaDataDatabase(
                  soundName: soundNameController.text, 
                  prompt: promptController.text, 
                  urlSound: widget.url, 
                  isPost: true
                );
                if(soundSave.errorSaveSound == null){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                }
              }
            ),
            SizedBox(height: 10),
            CustomButton(
              width: 120, 
              height: 40, 
              text: "Save", 
              onPressed:()async{
                final soundSave = context.read<SoundRecordingState>();
                await soundSave.uploadMetaDataDatabase(
                  soundName: soundNameController.text, 
                  prompt: promptController.text, 
                  urlSound: widget.url, 
                  isPost: false
                );
                if (!mounted) return;
                if(soundSave.errorSaveSound == null){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                }
              }
            ),
            SizedBox(height: 5),
            CustomButton(
              width: 120, 
              height: 40, 
              text: "Retake", 
              onPressed: (){
                final soundRecord = context.read<SoundRecordingState>();
                soundRecord.resetRecord();
                Navigator.of(context).pop();
              }
            ),
          ],
        ),
      )
    );
  }
}