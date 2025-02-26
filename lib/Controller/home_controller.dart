import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/weather_model.dart';

class HomeController extends GetxController {
  late WeatherModel weatherData;

  String get formattedLocalTime {
    DateTime parsedDate = DateTime.parse(weatherData.location!.localtime!);
    return DateFormat('EEEE, d MMMM, hh:mm a').format(parsedDate);
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize weatherData from Get.arguments
    weatherData = Get.arguments as WeatherModel;
  }
}
