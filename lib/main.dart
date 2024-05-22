import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quoty/controllers/quote_provider.dart';
import 'package:quoty/screens/history_screen.dart';
import 'package:quoty/screens/quote_screen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => QuoteProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quoty',

      routes: {
        '/': (context) => QuoteScreen(),
        '/history': (context) => HistoryScreen()
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}