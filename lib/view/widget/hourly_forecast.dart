import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/Controller/home_controller.dart';

class HourlyForecast extends GetView<HomeController> {
  final double w;
  final double h;
  const HourlyForecast({super.key, required this.w, required this.h});
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Container(
      margin: EdgeInsets.only(right: w * 0.02),
      width: w * 0.18,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(w * 0.05),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(controller.weatherData.current!.tempC!.toString(),
              style: TextStyle(color: Colors.white, fontSize: w * 0.03)),
          Icon(Icons.wb_sunny, color: Colors.yellow, size: w * 0.07),
          Text(
            controller.weatherData.current!.tempF!.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: w * 0.035,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
