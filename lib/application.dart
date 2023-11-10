import 'package:flutter/material.dart';
import 'package:todolist_app/auth_verify.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthVerify(),
    );
  }
}
