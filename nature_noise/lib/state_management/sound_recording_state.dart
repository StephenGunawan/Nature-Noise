
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http/http.dart' as http;
import 'package:nature_noise/models/sound_record_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';


class SoundRecordingState extends ChangeNotifier{
  final sound  = FlutterSoundRecorder();
  String? recordingPath;
  bool isPermmissionGranted = false;
  bool isReadyRecord = false;
  final StreamController<Uint8List> _audioController = StreamController<Uint8List>();
  final List<Uint8List> _audioRecord = [];
  String? _audioBlobURL;
  Timer? _time;
  Duration recordingDuration = Duration.zero;
  bool _currentlyUploading = false;
  String? errorSaveSound;

  Duration get recordDuration => recordingDuration;
  bool get isRecording => sound.isRecording;
  bool get isUploadLoading => _currentlyUploading;
  String? get audioBlobURL => _audioBlobURL;

  @override
  void dispose(){
    _audioController.close();
    sound.closeRecorder();
    super.dispose();
  }

  SoundRecordingState(){
    _audioController.stream.listen((buffer){
      _audioRecord.add(buffer);
    });
  }

  // if uploading a circular porgress indicator will appear
  void setUpload(bool isUploading){
    _currentlyUploading = isUploading;
    notifyListeners();
  }

  // start recording timer for web users 
  void  startTime (){
    _time?.cancel();
    recordingDuration = Duration.zero;
    _time = Timer.periodic(Duration(seconds: 1), (time){
      recordingDuration += Duration(seconds: 1);
      notifyListeners();
    });
  }

  //stop recording timer for web users
  void stopTime (){
    _time?.cancel();
  }

  //initialises micpermission for users to be able to record sound
  Future<void> micPermission() async {
    if(!kIsWeb){
      final isGranted = await Permission.microphone.request();
      debugPrint("Microphone permission status: $isGranted");
      if (isGranted != PermissionStatus.granted){
        throw "Need permission to access microphone";
      }
    }
    await sound.openRecorder();
    await sound.setSubscriptionDuration(
      const Duration(milliseconds: 100),
    );
    isReadyRecord = true;
    notifyListeners();
  }

  //start sound recording function 
  Future<void>startRecord() async{
    if(!isReadyRecord){
      return;
    }
    _audioRecord.clear();
    _audioBlobURL = null;
    //if users is using the web
    if(kIsWeb){
      await sound.startRecorder(
        toFile: 'recording.webm',
        codec: Codec.opusWebM,
        );
      startTime();
    }else{
      //if users is using mobile
      final directory = await getTemporaryDirectory();
      final audioPath = '${directory.path}/nature_sound_${DateTime.now().microsecondsSinceEpoch}.aac';
      await sound.startRecorder(toFile: audioPath);
      recordingPath = audioPath;
    }
    notifyListeners();
  } 

  //stops recording function
  Future<String?>stopRecord() async{
    if(!isReadyRecord){
      return null;
    }
    setUpload(true);
    String? urlDownload;
    //if users is using the web
    if(kIsWeb){
      stopTime();
      final urlBlob = await sound.stopRecorder();
      if(urlBlob == null){
        setUpload(false);
        return null;
      }
      //sends http get request and extract audio file then upload to firebase storage
      final http.Response res = await http.get(Uri.parse(urlBlob));
      final Uint8List bytes = res.bodyBytes;
      urlDownload = await uploadToRemote(bytes, isWeb: true);
      _audioBlobURL = urlDownload;
    }else{
      //if users is using mobile
      await sound.stopRecorder();
      final bytes = await File(recordingPath!).readAsBytes();
      urlDownload = await uploadToRemote(bytes, isWeb: false);
      _audioBlobURL = urlDownload;
    }
    setUpload(false);
    notifyListeners();
    return urlDownload;
  }

  //upload sound to firebase storage
  Future<String>uploadToRemote(Uint8List bytesAudio,{required bool isWeb}) async {
    try{
      final storageReference = FirebaseStorage.instance.ref();
      final extension = isWeb ? 'webm' : 'aac';
      final soundType = isWeb ? 'audio/webm' : 'audio/webm';
      final file = storageReference.child('Recordings/recording_${DateTime.now().millisecondsSinceEpoch}.$extension');
      final upload = file.putData(bytesAudio, SettableMetadata(contentType: soundType));

      await upload;
      return await file.getDownloadURL();
    }catch(e){
      debugPrint('Upload Failed');
      rethrow;
    }
  }

  //resest all audio variables for next recording 
  void resetRecord(){
    _audioRecord.clear();
    _audioBlobURL = null;
    errorSaveSound = null;
    recordingDuration = Duration.zero;
    notifyListeners();
  }

  //upload to firebase firestore database with metadata
  Future<void>uploadMetaDataDatabase({
    required String soundName,
    required String prompt,
    required String urlSound,
    required bool isPost
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null){
      return;
    }
    errorSaveSound = null;
    notifyListeners();
    if (soundName.isEmpty){
      errorSaveSound = "Please input a name for the sound";
      notifyListeners();
      return;
    }
    final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    final username = doc.data()?['username'] ?? 'unknown';
    final recordingID = const Uuid().v4();

    final rec = SoundRecord(
      recordingID: recordingID,
      uid: user.uid, 
      soundName: soundName,
      userName: username, 
      prompt: prompt, 
      timeCreated: DateTime.now(), 
      recordingURL: urlSound, 
      isPost: isPost
      );

    await FirebaseFirestore.instance
      .collection('userNatureNoiseRecordings')
      .doc(recordingID)
      .set(rec.toJson());

    errorSaveSound = null;
    notifyListeners();  
  }
}