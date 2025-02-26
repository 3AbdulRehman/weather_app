import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/rep/weather_services.dart';

class SearchCityController extends GetxController {
  final WeatherService _weatherService = WeatherService();
  TextEditingController cityController = TextEditingController();

  var weatherList = <WeatherModel>[].obs;
  var isLoading = false.obs;
  var city = ''.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   getCurrentLocation();
  // }

  Future<void> fetchWeatherData() async {
    try {
      isLoading.value = true;
      final result =
          await _weatherService.fetchWeather(cityController.text.trim());
      weatherList.add(result);
    } catch (e) {
      Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      isLoading.value = true;
      // Check permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          isLoading.value = false;
          Get.snackbar(
              "Permission Denied", "Enable location permissions from settings");
          return;
        }
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.high,
      );

      // Get placemarks using latitude and longitude
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        city.value = placemarks.first.locality ?? "Unknown City";
        print(city.value);
        fetchWeatherData();
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch location: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
