import 'package:bitcoin/settings.dart';
import 'package:flutter/material.dart';
import 'home.dart';

void main(){
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/settings': (context) => Settings()
      },
      debugShowCheckedModeBanner: false,
      home: Home(),
    )
  );
}