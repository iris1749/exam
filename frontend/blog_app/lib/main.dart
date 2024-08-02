import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/post_model.dart';
import 'screens/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PostModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}