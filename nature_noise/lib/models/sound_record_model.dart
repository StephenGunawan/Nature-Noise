class SoundRecord{
  final String recordingID;
  final String uid;
  final String soundName;
  final String userName;
  final String prompt;
  final DateTime timeCreated;
  final String recordingURL;
  final bool isPost;

  SoundRecord({
    required this.recordingID,
    required this.uid,
    required this.soundName,
    required this.userName,
    required this.prompt,
    required this.timeCreated,
    required this.recordingURL,
    required this.isPost
  });

  Map<String, dynamic> toJson(){
    return {
      'recording_ID': recordingID,
      'uid': uid,
      'sound_name': soundName,
      'username': userName,
      'prompt': prompt,
      'created_time': timeCreated,
      'sound_URL': recordingURL,
      'visible_all_users': isPost,
    };
  }

  factory SoundRecord.fromJson(Map<String, dynamic> jsonUser){
    return SoundRecord(
      recordingID: jsonUser['recording_ID'],
      uid: jsonUser['uid'],
      soundName: jsonUser['sound_name'],
      userName: jsonUser['username'],
      prompt:jsonUser['prompt'],
      timeCreated: jsonUser['created_time'],
      recordingURL: jsonUser['sound_URL'],
      isPost: jsonUser['visible_all_users'],
    );
  }
}