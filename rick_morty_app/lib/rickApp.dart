import 'package:flutter/material.dart';
import 'package:rick_morty_app/pages/home_page.dart';

class RickApp extends StatelessWidget {
  const RickApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage(),
    );
  }
}
