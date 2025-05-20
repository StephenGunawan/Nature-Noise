import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:nature_noise/screens/save_record_screen.dart';
import 'package:nature_noise/state_management/sound_recording_state.dart';
import 'package:provider/provider.dart';

class SoundRecord extends StatefulWidget {
  const SoundRecord({super.key});

  @override
  State<SoundRecord> createState() => _SoundRecordState();
}

class _SoundRecordState extends State<SoundRecord> {
  SoundRecordingState? sound;

  @override 
  void dispose(){
    sound?.sound.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progressDuration = context.watch<SoundRecordingState>();
    final  isRecord = progressDuration.isRecording;

    // load when uploading file to firebase storage
    if(progressDuration.isUploadLoading){
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),    
        )
      );
    }
    return Scaffold(
    appBar: AppBar(),
    body: Center(
      child: Column(
        children: [  
            SizedBox(height: 120),
            //if user access app through mobile for sound record timer 
            if(!kIsWeb) ...[
              StreamBuilder<RecordingDisposition>(
                stream: progressDuration.sound.onProgress, 
                builder: (context, snapshot){
                  final recordTimeLength = snapshot.hasData ? snapshot.data!.duration : Duration.zero;
                  final minutesTime =  recordTimeLength.inMinutes.remainder(60).toString();
                  final secondsTime =  recordTimeLength.inSeconds.remainder(60).toString().padLeft(2,'0');
                  return Text(
                    "$minutesTime:$secondsTime",
                    style: TextStyle(
                      fontFamily: 'KiwiMaru',
                      fontSize: 90,
                      fontWeight: FontWeight.w600
                    )
                  );
                }
              ),
            ]else ...[
              //if user access app through web for sound record timer 
              Text(
                "${progressDuration.recordDuration.inMinutes.remainder(60).toString()}:${progressDuration.recordDuration.inSeconds.remainder(60).toString().padLeft(2,'0')}",
                style: TextStyle(
                  fontFamily: 'KiwiMaru',
                  fontSize: 90,
                  fontWeight: FontWeight.w600
                )
              )
            ],
            SizedBox(height: 120),
            // Button to start recording sound
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 5,
                minimumSize: Size(100,100),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                ),
                backgroundColor: isRecord? Color(0xFFFF0000): Color(0xFF89F336),
              ),
              onPressed: () async {
                final soundRecord = context.read<SoundRecordingState>();
                // must request permission to use microphone
                if (!soundRecord.isReadyRecord){
                  try{
                    await soundRecord.micPermission();
                  }catch (e){
                    debugPrint("microphone permission not granted");
                    return;
                  }
                }
                // start and stop recording sound 
                if(soundRecord.isRecording){
                  await soundRecord.stopRecord();
                  if(!mounted)return;  
                  await Navigator.push(context, MaterialPageRoute(builder: (context)=>SaveRecord()));
                  soundRecord.resetRecord();
                }else{
                  await soundRecord.startRecord();
                }
              }, 
              // icon for  microphone 
              child:Icon(
                Icons.mic, 
                size: 50,
                color: isRecord ? Color.fromARGB(255, 135, 0, 0): Color.fromARGB(255, 82, 156, 25),
              ),
            ),
          ],
        )
      ),
    );
  }
}