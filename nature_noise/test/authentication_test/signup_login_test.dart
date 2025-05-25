import "package:fake_cloud_firestore/fake_cloud_firestore.dart";
import "package:firebase_auth_mocks/firebase_auth_mocks.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:nature_noise/screens/authentication/login.dart";
import "package:nature_noise/screens/authentication/sign_up.dart";
import "package:nature_noise/screens/authentication/signup_login.dart";
import "package:nature_noise/state_management/authentication_state.dart";
import "package:nature_noise/state_management/sound_recording_state.dart";
import "package:provider/provider.dart";

void main(){

  final authMock = MockFirebaseAuth();
  final fireStoreMock = FakeFirebaseFirestore();
  testWidgets('Signup and Login buttons in start screen with title', (WidgetTester test) async{
      await test.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider(create:(_) => AuthenticationState(
            firebaseAuth: authMock,
            firebaseFirestore: fireStoreMock,

            )),
          ChangeNotifierProvider(create: (_) => SoundRecordingState())
        ],
        child: const MaterialApp(home: SignupLogin())));

      expect(find.text('Nature Noise'), findsOneWidget);

      expect(find.byKey(Key('loginButton')), findsOneWidget);
      expect(find.byKey(Key('signUpButton')), findsOneWidget);

      await test.tap(find.byKey(Key('loginButton')));
      await test.pumpAndSettle();
      expect(find.byType(Login), findsOneWidget);

      Navigator.of(test.element(find.byType(Login))).pop();
      await test.pumpAndSettle();

      await test.tap(find.byKey(Key('signUpButton')));
      await test.pumpAndSettle();
      expect(find.byType(SignUp), findsOneWidget);
    }
  );
}