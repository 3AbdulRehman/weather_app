import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/Controller/search_controller.dart';

class SearchSreen extends GetView<SearchCityController> {
  const SearchSreen({super.key});

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
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                Center(
                  child: Lottie.asset(
                    'assets/icons/Animation - 1740487902646.json',
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Weather',
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                  textAlign: TextAlign.start,
                ),
                const Text(
                  'ForeCasts',
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () async {
                      controller.fetchWeatherData();
                    },
                    child: Obx(() => controller.isLoading.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            "Get Start",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
