import 'package:flutter/material.dart';

import 'product_list_screen.dart';

class Lab5App extends StatelessWidget {
  const Lab5App({super.key});

  @override
  Widget build(BuildContext context) {
    const shopeeOrange = Color(0xff053c75);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 5 - Product Store',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: shopeeOrange),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: shopeeOrange,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        cardTheme: const CardThemeData(
          color: Colors.white,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
      home: const ProductListScreen(),
    );
  }
}
