import 'package:flutter/material.dart';
import 'package:is_task/screens/filter_screen.dart';
import 'package:is_task/screens/search_screenn.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Internship Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        '/search': (context) => SearchScreen(),
        '/filters': (context) => FilterScreen(filters: {}),
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/search');
    });

    return const Scaffold(
      body: Center(
        child: Text('Welcome to Internship Search',
            style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
