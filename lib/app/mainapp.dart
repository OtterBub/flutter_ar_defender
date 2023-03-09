import 'package:flutter/material.dart';

import './pages/ar_page.dart';
import './pages/home_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR Defender Project',
      theme: ThemeData(),
      // home: const ARPage(title: 'AR Defender'),
      home: const HomePage(title: 'Home Page',),
    );
  }
}
