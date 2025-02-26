import 'package:weather_app/constant/constant.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherService {
  Future<WeatherModel> fetchWeather(String city) async {
    try {
      final response = await dio.get(
        apiURL,
        queryParameters: {'key': apiKey, 'q': city, 'aqi': 'no'},
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw Exception("Failed to fetch weather data");
      }
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }
}
