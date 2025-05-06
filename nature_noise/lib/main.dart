import 'package:flutter/material.dart';
import 'package:nature_noise/screens/authentication/signup_login.dart';

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

void main() {
  runApp(const MyApp());
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
          foregroundColor: lightColourTheme.onPrimary,
        ),
        cardTheme: const CardTheme().copyWith(
          color: lightColourTheme.onSecondary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: lightColourTheme.onPrimary, 
            foregroundColor: lightColourTheme.onSurface,           
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SignupLogin()//HomeScreen(),
    );
  }
}
