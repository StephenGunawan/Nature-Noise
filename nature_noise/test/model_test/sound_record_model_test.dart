import 'package:flutter_test/flutter_test.dart';
import 'package:nature_noise/models/sound_record_model.dart';

void main(){
  //unit test sound record model for sound recording entity
  group("Sound record model test",(){
    final soundTest = SoundRecord(
      recordingID: "record1", 
      uid: "testUser1", 
      soundName: "Nature noise 1", 
      userName: "Mark_77", 
      prompt: "The first recording.", 
      timeCreated: DateTime.parse('2025-05-23T07:00:00Z'), 
      recordingURL: "https://recording.com/sound.aac", 
      isPost: true
      );

      test('test use json to extract the correct mapping', (){
        final jsonTest = soundTest.toJson();
        expect(jsonTest['recording_ID'], 'record1');
        expect(jsonTest['uid'], 'testUser1');
        expect(jsonTest['sound_name'], 'Nature noise 1');
        expect(jsonTest['username'], 'Mark_77');
        expect(jsonTest['prompt'], 'The first recording.');
        expect(jsonTest['created_time'], DateTime.parse('2025-05-23T07:00:00Z'));
        expect(jsonTest['sound_URL'], "https://recording.com/sound.aac");
        expect(jsonTest['visible_all_users'], true);
      });

      test('test use json to create sound record model',(){
        final Map<String, dynamic> jsonTest = {
          'recording_ID': "record1", 
          'uid': "testUser1", 
          'sound_name': "Nature noise 1", 
          'username': "Mark_77", 
          'prompt': "The first recording.", 
          'created_time': DateTime.parse('2025-05-23T07:00:00Z'), 
          'sound_URL': "https://recording.com/sound.aac", 
          'visible_all_users': true
        };

        final testSound = SoundRecord.fromJson(jsonTest);
        expect(testSound.recordingID, 'record1');
        expect(testSound.uid, 'testUser1');
        expect(testSound.soundName, 'Nature noise 1');
        expect(testSound.userName, 'Mark_77');
        expect(testSound.prompt, 'The first recording.');
        expect(testSound.timeCreated, DateTime.parse('2025-05-23T07:00:00Z'));
        expect(testSound.recordingURL, "https://recording.com/sound.aac");
        expect(testSound.isPost, true);
      });
  });
}