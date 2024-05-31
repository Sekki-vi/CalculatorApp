import 'package:calculator_app/calculator_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),

      //Remove the debug banner and change the homescreen to the calculator view class
      debugShowCheckedModeBanner: true,
      home: const CalculatorView(),
    );
  }
}