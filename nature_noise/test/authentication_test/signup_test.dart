
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nature_noise/screens/authentication/login.dart';
import 'package:nature_noise/screens/authentication/sign_up.dart';
import 'package:nature_noise/state_management/authentication_state.dart';
import 'package:nature_noise/state_management/sound_recording_state.dart';
import 'package:provider/provider.dart';


void main(){
  late MockFirebaseAuth mockAuth;
  late FakeFirebaseFirestore fakeFirestore;
  late AuthenticationState authState;

  setUp((){
    mockAuth = MockFirebaseAuth();
    fakeFirestore = FakeFirebaseFirestore();

    authState = AuthenticationState(
      firebaseAuth: mockAuth,
      firebaseFirestore: fakeFirestore,
    );
  });
  testWidgets('Successful sign up test', (WidgetTester test) async{
      await test.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: authState
          ),
          ChangeNotifierProvider(create: (_) => SoundRecordingState())
        ],
        child: const MaterialApp(home: SignUp()
        )
      )
    );

      expect(find.text('Nature Noise'), findsOneWidget);
      expect(find.text('SIGN UP'), findsExactly(2));

      await test.enterText(find.byKey(Key("firstNameInput")), "Mathew");
      await test.enterText(find.byKey(Key("lastNameInput")), "Ben");
      await test.enterText(find.byKey(Key("userNameInput")), "ben_10");
      await test.enterText(find.byKey(Key("emailInput")), "Mathew@gmail.com");
      await test.enterText(find.byKey(Key("passwordInput")), "123456789");
      await test.enterText(find.byKey(Key("confirmPasswordInput")), "123456789");

      final signUpButton = find.byKey(Key("signUpButton"));
      expect(signUpButton, findsOneWidget);
      await test.ensureVisible(signUpButton);
      await test.tap(signUpButton);
      await test.pumpAndSettle();
      expect(find.byType(Login), findsOneWidget);
    }
  );

  testWidgets('Passwords do not match error', (WidgetTester test) async{
      await test.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: authState
          ),
          ChangeNotifierProvider(create: (_) => SoundRecordingState())
        ],
        child: const MaterialApp(home: SignUp()
        )
      )
    );

      expect(find.text('Nature Noise'), findsOneWidget);
      expect(find.text('SIGN UP'), findsExactly(2));

      await test.enterText(find.byKey(Key("firstNameInput")), "Mathew");
      await test.enterText(find.byKey(Key("lastNameInput")), "Ben");
      await test.enterText(find.byKey(Key("userNameInput")), "ben_10");
      await test.enterText(find.byKey(Key("emailInput")), "Mathew@gmail.com");
      await test.enterText(find.byKey(Key("passwordInput")), "123456789");
      await test.enterText(find.byKey(Key("confirmPasswordInput")), "abcdefg");

      final signUpButton = find.byKey(Key("signUpButton"));
      expect(signUpButton, findsOneWidget);
      await test.ensureVisible(signUpButton);
      await test.tap(signUpButton);
      await test.pumpAndSettle();

      expect(find.text("Passwords needs to match"),findsOneWidget);
    }
  );

  testWidgets('Missing inputs error', (WidgetTester test) async{
      await test.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: authState
          ),
          ChangeNotifierProvider(create: (_) => SoundRecordingState())
        ],
        child: const MaterialApp(home: SignUp()
        )
      )
    );

      expect(find.text('Nature Noise'), findsOneWidget);
      expect(find.text('SIGN UP'), findsExactly(2));

      await test.enterText(find.byKey(Key("firstNameInput")), "Mathew");
      await test.enterText(find.byKey(Key("lastNameInput")), "Ben");
      await test.enterText(find.byKey(Key("emailInput")), "Mathew@gmail.com");
      await test.enterText(find.byKey(Key("passwordInput")), "123456789");
      await test.enterText(find.byKey(Key("confirmPasswordInput")), "abcdefg");

      final signUpButton = find.byKey(Key("signUpButton"));
      expect(signUpButton, findsOneWidget);
      await test.ensureVisible(signUpButton);
      await test.tap(signUpButton);
      await test.pumpAndSettle();

      expect(find.text("missing input"),findsOneWidget);
    }
  );
}
