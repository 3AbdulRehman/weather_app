import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/Controller/search_controller.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/view/widget/hourly_forecast.dart';
import 'package:weather_app/view/widget/weather_stats.dart';

class HomeScreen extends GetView<SearchCityController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SearchCityController());
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
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.weatherList.isEmpty) {
            return const Center(
                child: Text("Search for a city to see the weather!"));
          } else {
            final WeatherModel weather = controller.weatherList.first;
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: h * 0.06, horizontal: w * 0.04),
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
                                  weather.location!.name!,
                                  style: TextStyle(
                                    fontSize: w * 0.05,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.searching();
                              },
                              child: Icon(Icons.more_vert,
                                  color: Colors.white, size: w * 0.06),
                            ),
                          ],
                        ),
                        SizedBox(height: h * 0.01),
                        controller.issearch.value
                            ? TextField(
                                controller: controller.cityController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Search Other City Weather ..",
                                  hintStyle:
                                      const TextStyle(color: Colors.white70),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.2),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 15,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.search,
                                        color: Colors.amber),
                                    onPressed: () {
                                      controller.searcCity();
                                    },
                                  ),
                                ),
                              )
                            : Text(
                                controller.formattedLocalTime,
                                style: TextStyle(
                                    fontSize: w * 0.04, color: Colors.white),
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
                                    weather.current!.tempC!.toString(),
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
                                          borderRadius:
                                              BorderRadius.circular(100)),
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
                                  right: w * 0.05,
                                  bottom: h * 0.04,
                                  child: Text(
                                    "Condition",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: w * 0.055,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white),
                                  ),
                                ),
                                Positioned(
                                  right: w * 0.07,
                                  bottom: h * 0.01,
                                  child: Text(
                                    weather.current!.condition!.text!,
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
                              label: weather.current!.precipMm!.toString(),
                              subText: "Precipitation",
                              w: w,
                              h: h,
                            ),
                            WeatherStat(
                              icon: Icons.water,
                              label: weather.current!.humidity!.toString(),
                              subText: "Humidity",
                              w: w,
                              h: h,
                            ),
                            WeatherStat(
                              icon: Icons.air,
                              label: weather.current!.windKph!.toString(),
                              subText: "Wind Speed",
                              w: w,
                              h: h,
                            ),
                          ],
                        ),

                        SizedBox(height: h * 0.03),

                        // 🔹 Hourly Forecast
                        Text(
                          "Current Values",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: w * 0.045,
                          ),
                        ),
                        SizedBox(height: h * 0.02),

                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              HourlyForecast(
                                w: w,
                                h: h,
                                temf: weather.current!.tempF!,
                                temp: weather.current!.tempC!,
                                name: 'Tempera',
                                icon: Icons.wb_sunny,
                              ),
                              HourlyForecast(
                                w: w,
                                h: h,
                                temf: weather.current!.windKph!,
                                temp: weather.current!.windMph!,
                                name: 'Wind Sp',
                                icon: Icons.air_outlined,
                              ),
                              HourlyForecast(
                                w: w,
                                h: h,
                                temf: weather.current!.pressureIn!,
                                temp: weather.current!.pressureMb!,
                                name: 'pressure',
                                icon: Icons.speed_rounded,
                              ),
                              HourlyForecast(
                                w: w,
                                h: h,
                                temf: weather.current!.feelslikeC!,
                                temp: weather.current!.feelslikeF!,
                                name: 'Feel Like',
                                icon: Icons.face,
                              ),
                              HourlyForecast(
                                w: w,
                                h: h,
                                temf: weather.current!.precipIn!,
                                temp: weather.current!.precipMm!,
                                name: 'Precipt',
                                icon: Icons.precision_manufacturing,
                              ),
                              HourlyForecast(
                                w: w,
                                h: h,
                                temf: weather.current!.windchillC!,
                                temp: weather.current!.windchillF!,
                                name: 'wind chill',
                                icon: Icons.wind_power_outlined,
                              ),
                              HourlyForecast(
                                w: w,
                                h: h,
                                temf: weather.current!.heatindexC!,
                                temp: weather.current!.heatindexF!,
                                name: 'Heat Index',
                                icon: Icons.health_and_safety_outlined,
                              ),
                              HourlyForecast(
                                w: w,
                                h: h,
                                temf: weather.current!.dewpointC!,
                                temp: weather.current!.dewpointF!,
                                name: 'down points',
                                icon: Icons.health_and_safety_outlined,
                              ),
                              HourlyForecast(
                                w: w,
                                h: h,
                                temf: weather.current!.gustKph!,
                                temp: weather.current!.gustMph!,
                                name: 'Gust',
                                icon: Icons.health_and_safety_outlined,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: h * 0.03),
                        // 🔹 Other Cities
                        Text(
                          "Location Details",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: w * 0.045,
                          ),
                        ),
                        SizedBox(height: h * 0.02),

                        // 🔹 Location Details Section
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: h * 0.02, horizontal: w * 0.04),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(w * 0.05),
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 112, 62, 228),
                                Color(0xFF673AB7),
                                Color.fromARGB(255, 88, 63, 134),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 🔹 Location Name
                              Row(
                                children: [
                                  Icon(Icons.location_on,
                                      color: Colors.white, size: w * 0.06),
                                  SizedBox(width: w * 0.02),
                                  Text(
                                    weather.location!.region!,
                                    style: TextStyle(
                                      fontSize: w * 0.05,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: h * 0.01),

                              // 🔹 Region and Country
                              Row(
                                children: [
                                  Icon(Icons.place,
                                      color: Colors.white, size: w * 0.05),
                                  SizedBox(width: w * 0.01),
                                  Text(
                                    "${weather.location!.country!}",
                                    style: TextStyle(
                                      fontSize: w * 0.04,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: h * 0.01),

                              // 🔹 Latitude and Longitude
                              Row(
                                children: [
                                  Icon(Icons.explore,
                                      color: Colors.white, size: w * 0.05),
                                  SizedBox(width: w * 0.02),
                                  Text(
                                    "Lat: ${weather.location!.lat!}, Lon: ${weather.location!.lon!}",
                                    style: TextStyle(
                                      fontSize: w * 0.04,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: h * 0.01),

                              // 🔹 Timezone and Local Time
                              Row(
                                children: [
                                  Icon(Icons.access_time,
                                      color: Colors.white, size: w * 0.05),
                                  SizedBox(width: w * 0.02),
                                  Text(
                                    "Timezone: ${weather.location!.tzId!}",
                                    style: TextStyle(
                                      fontSize: w * 0.04,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: h * 0.01),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today,
                                      color: Colors.white, size: w * 0.05),
                                  SizedBox(width: w * 0.02),
                                  Text(
                                    "Local Time: ${weather.location!.localtime!}",
                                    style: TextStyle(
                                      fontSize: w * 0.04,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
