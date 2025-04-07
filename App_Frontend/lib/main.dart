import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/home.dart';
import 'screens/stats.dart';
import 'screens/info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HyBrix App',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/stats': (context) => StatsScreen(),
        '/info': (cntext) => InfoScreen(),
      },
    );
  }
}
