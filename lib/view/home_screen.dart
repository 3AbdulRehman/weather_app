import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/Controller/home_controller.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/view/widget/hourly_forecast.dart';
import 'package:weather_app/view/widget/weather_stats.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: h,
        width: w,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF512DA8),
              Color(0xFF673AB7),
              Color(0xFF9575CD),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding:
                EdgeInsets.symmetric(vertical: h * 0.06, horizontal: w * 0.04),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 Location & Date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                color: Colors.white, size: w * 0.06),
                            SizedBox(width: w * 0.02),
                            Text(
                              controller.weatherData.location!.name!,
                              style: TextStyle(
                                fontSize: w * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.more_vert,
                            color: Colors.white, size: w * 0.06),
                      ],
                    ),
                    SizedBox(height: h * 0.01),
                    Text(
                      controller.formattedLocalTime,
                      style: TextStyle(fontSize: w * 0.04, color: Colors.white),
                    ),
                    SizedBox(height: h * 0.02),

                    // 🔹 Weather Card with Lottie Animation
                    Center(
                      child: Container(
                        height: h * 0.2,
                        width: w * 0.65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(w * 0.05),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 112, 62, 228),
                              Color(0xFF673AB7),
                              Color(0xFF9575CD),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Stack(
                          clipBehavior: Clip
                              .none, // Allows overflow outside the container
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                controller.weatherData.current!.tempC!
                                    .toString(),
                                style: TextStyle(
                                  fontSize: w * 0.15,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Positioned(
                                top: h * 0.03,
                                right: 40,
                                child: Container(
                                  height: h * 0.03,
                                  width: h * 0.03,
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      border: Border.all(
                                          color: Colors.green,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(100)),
                                )),
                            Positioned(
                              top: h * 0.04,
                              left: -w * 0.15,
                              child: SizedBox(
                                height: h * 0.2,
                                width: w * 0.5,
                                child: Lottie.asset(
                                  'assets/icons/Animation - 1740487902646.json',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: w * 0.07,
                              bottom: h * 0.01,
                              child: Text(
                                controller
                                    .weatherData.current!.condition!.text!,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: w * 0.055,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: h * 0.03),

                    // 🔹 Weather Stats (Precipitation, Humidity, Wind Speed)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        WeatherStat(
                          icon: Icons.water_drop,
                          label: controller.weatherData.current!.precipMm!
                              .toString(),
                          subText: "Precipitation",
                          w: w,
                          h: h,
                        ),
                        WeatherStat(
                          icon: Icons.water,
                          label: controller.weatherData.current!.humidity!
                              .toString(),
                          subText: "Humidity",
                          w: w,
                          h: h,
                        ),
                        WeatherStat(
                          icon: Icons.air,
                          label: controller.weatherData.current!.windKph!
                              .toString(),
                          subText: "Wind Speed",
                          w: w,
                          h: h,
                        ),
                      ],
                    ),

                    SizedBox(height: h * 0.03),

                    // 🔹 Hourly Forecast
                    Text(
                      "Today",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: w * 0.045,
                      ),
                    ),
                    SizedBox(height: h * 0.02),

                    SizedBox(
                      height: h * 0.15,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) =>
                            HourlyForecast(w: w, h: h),
                      ),
                    ),

                    SizedBox(height: h * 0.03),

                    // 🔹 Other Cities
                    Text(
                      "Other Cities",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: w * 0.045,
                      ),
                    ),
                    SizedBox(height: h * 0.02),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        Container(
                          height: h * 0.08,
                          width: w * 0.65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(w * 0.05),
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 112, 62, 228),
                                Color(0xFF673AB7),
                                Color(0xFF9575CD),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Stack(
                            clipBehavior: Clip
                                .none, // Allows overflow outside the container
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  controller.weatherData.current!.tempC!
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: w * 0.1,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: h * 0.01,
                                right: 40,
                                child: Container(
                                  height: h * 0.03,
                                  width: h * 0.03,
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      border: Border.all(
                                          color: Colors.green,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                              ),
                              Positioned(
                                top: h * 0.01,
                                left: -w * 0.02,
                                child: SizedBox(
                                  height: h * 0.1,
                                  width: w * 0.1,
                                  child: Lottie.asset(
                                    'assets/icons/Animation - 1740487902646.json',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: w * 0.07,
                                bottom: h * 0.01,
                                child: Text(
                                  controller
                                      .weatherData.current!.condition!.text!,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: w * 0.02,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
