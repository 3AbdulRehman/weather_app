import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/rep/weather_services.dart';
import 'package:weather_app/view/home_screen.dart';

class SearchCityController extends GetxController {
  final WeatherService _weatherService = WeatherService();
  TextEditingController cityController = TextEditingController();

  var weatherList = <WeatherModel>[].obs;
  var isLoading = false.obs;
  var loadingIs = false.obs;
  var city = ''.obs;

  ///
  // Search
  RxBool issearch = false.obs;
  void searching() {
    issearch.value = !issearch.value;
  }

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> searcCity() async {
    try {
      isLoading.value = true;
      final result =
          await _weatherService.fetchWeather(cityController.text.trim());
      if (weatherList.isNotEmpty) {
        weatherList.clear();
        weatherList.add(result);
      }
    } catch (e) {
      Exception(e.toString());
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchWeatherData() async {
    try {
      isLoading.value = true;
      final result = await _weatherService.fetchWeather(city.value);
      weatherList.add(result);
      if (weatherList.isNotEmpty) {
        Get.to(() => const HomeScreen());
      }
    } catch (e) {
      Exception(e.toString());
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      loadingIs.value = true;
      // Check permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          loadingIs.value = false;
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
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch location: $e");
    } finally {
      loadingIs.value = false;
    }
  }

  String get formattedLocalTime {
    DateTime parsedDate =
        DateTime.parse(weatherList.first.location!.localtime!);
    return DateFormat('EEEE, d MMMM, hh:mm a').format(parsedDate);
  }
}
