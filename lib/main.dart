import 'package:flutter/material.dart';

import 'page/page_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        useMaterial3: false,
      ),
      home: const HomePage(),
    );
  }
}