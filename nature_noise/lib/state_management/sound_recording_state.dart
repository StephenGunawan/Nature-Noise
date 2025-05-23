
import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


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

  void setUpload(bool isUploading){
    _currentlyUploading = isUploading;
    notifyListeners();
  }

  void  startTime (){
    _time?.cancel();
    recordingDuration = Duration.zero;
    _time = Timer.periodic(Duration(seconds: 1), (time){
      recordingDuration += Duration(seconds: 1);
      notifyListeners();
    });
  }

  void stopTime (){
    _time?.cancel();
  }

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

  Future<void>startRecord() async{
    if(!isReadyRecord){
      return;
    }
    _audioRecord.clear();
    _audioBlobURL = null;
    if(kIsWeb){
      await sound.startRecorder(toStream: _audioController.sink);
      startTime();
    }else{
      final directory = await getTemporaryDirectory();
      final audioPath = '${directory.path}/nature_sound_${DateTime.now().microsecondsSinceEpoch}.aac';
      await sound.startRecorder(toFile: audioPath);
      recordingPath = audioPath;
    }
    notifyListeners();
  } 

  Future<String?>stopRecord() async{
    if(!isReadyRecord){
      return null;
    }
    setUpload(true);
    String? urlDownload;
    if(kIsWeb){
      stopTime();
      await sound.stopRecorder();
      final length = _audioRecord.fold<int>(0,(sum,chunk) => sum +chunk.length);
      final bytes = Uint8List(length);
      int offset = 0;
      for(var chunk in _audioRecord){
        bytes.setRange(offset, offset + chunk.length, chunk);
        offset += chunk.length;
      }
      urlDownload = await uploadToRemote(bytes);
      _audioBlobURL = urlDownload;
    }else{
      await sound.stopRecorder();
      final bytes = await File(recordingPath!).readAsBytes();
      urlDownload = await uploadToRemote(bytes);
      _audioBlobURL = urlDownload;
    }
    setUpload(false);
    notifyListeners();
    return urlDownload;
  }

  Future<String>uploadToRemote(Uint8List bytesAudio) async {
    try{
      final storageReference = FirebaseStorage.instance.ref();
      final file = storageReference.child('Recordings/recording_${DateTime.now().millisecondsSinceEpoch}.aac');
      final upload = file.putData(bytesAudio, SettableMetadata(contentType: 'audio/aac'));

      await upload;
      return await file.getDownloadURL();
    }catch(e){
      debugPrint('Upload Failed');
      rethrow;
    }
  }

  void resetRecord(){
    _audioRecord.clear();
    _audioBlobURL = null;
    recordingDuration = Duration.zero;
    notifyListeners();
  }
}