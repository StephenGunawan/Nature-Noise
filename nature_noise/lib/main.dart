import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nature_noise/firebase_options.dart';
import 'package:nature_noise/screens/authentication/signup_login.dart';
import 'package:nature_noise/screens/home_screen.dart';
import 'package:nature_noise/state_management/authentication_state.dart';
import 'package:provider/provider.dart';


var lightColourTheme = 
  ColorScheme(
    brightness: Brightness.light, 
    primary:  const Color(0xFF87CEEB), 
    onPrimary: const Color(0xFF89F336), 
    secondary: const Color(0xFFFFDB02), 
    secondaryContainer: const Color(0xFFFFDB02), 
    onSecondary: const Color(0xFFDF6D26), 
    error: const Color(0xFFFF0000), 
    onError: const Color(0xFFFFFFFF), 
    surface: const Color(0xFFFFFFFF), 
    onSurface: const Color.fromARGB(255, 0, 0, 0)
    );

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AuthenticationState())
  ],
  child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      theme: ThemeData().copyWith(
        colorScheme: lightColourTheme,
        scaffoldBackgroundColor: lightColourTheme.primary,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(
          backgroundColor: lightColourTheme.secondary,
          unselectedItemColor: lightColourTheme.onSecondary,
          selectedItemColor: lightColourTheme.onSecondary,
        ),
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: lightColourTheme.primary,
          foregroundColor: lightColourTheme.onSurface,
        ),
        cardTheme: const CardTheme().copyWith(
          color: lightColourTheme.onPrimary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: lightColourTheme.onPrimary, 
            foregroundColor: lightColourTheme.onSurface,           
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Consumer<AuthenticationState>(
        builder: (
          BuildContext context,
          AuthenticationState value,
          Widget? child) {  
            if (value.isSignedin){
              return HomeScreen();
            }else{
              return SignupLogin();
            }
          },
        )
    );
  }
}
