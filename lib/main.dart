import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:weather_app/routes/app_pages.dart';
import 'package:weather_app/view/search_sreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather App ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      
      ),
      // initialRoute: AppPages.initial,
      // getPages: AppPages.pages,
      
      // getPages: AppPages.pages,
      home: const SearchSreen(),
    );
  }
}
