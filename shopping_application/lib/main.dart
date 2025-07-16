import 'package:flutter/material.dart';
//import 'package:shopping_application/global_product.dart';
import 'package:shopping_application/homePage.dart';
//import 'package:shopping_application/product_details_page.dart';
//import 'homePage.dart';
// import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(245, 247, 249, 1),
          primary: Color.fromRGBO(256, 206, 1, 1),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          bodySmall: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      debugShowCheckedModeBanner: false,
      title: 'Shopping App',
      home: Homepage(),
    );
  }
}
