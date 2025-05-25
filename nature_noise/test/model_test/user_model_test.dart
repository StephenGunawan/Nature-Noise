import 'package:flutter_test/flutter_test.dart';
import 'package:nature_noise/models/user_model.dart';

void main(){
  group("User data model test",(){
    final userDataTest = UserData(
      firstName: "Mark", 
      lastName: "Ben",
      userName: "Mark_77", 
      email: "test@gmail.com",
      uid: "testUser1", 
      );

      test('test use json to extract the correct mapping', (){
        final jsonTest = userDataTest.toJson();
        expect(jsonTest['first_name'], 'Mark');
        expect(jsonTest['last_name'], 'Ben');
        expect(jsonTest['username'], 'Mark_77');
        expect(jsonTest['email'], 'test@gmail.com');
        expect(jsonTest['uid'], 'testUser1');
      });

      test('test use json to create sound record model',(){
        final Map<String, dynamic> jsonTest = {
          'first_name': "Mark", 
          'last_name': "Ben", 
          'username': "Mark_77", 
          'email': "test@gmail.com", 
          'uid': "testUser1", 
        };

        final testUser = UserData.fromJson(jsonTest);
        expect(testUser.firstName, 'Mark');
        expect(testUser.lastName, 'Ben');
        expect(testUser.userName, 'Mark_77');
        expect(testUser.email, 'test@gmail.com');
        expect(testUser.uid, 'testUser1');
      });
  });
}