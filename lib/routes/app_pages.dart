import 'package:get/get.dart';
import 'package:weather_app/routes/app_routes.dart';
import 'package:weather_app/view/home_screen.dart';

class AppPages {
    static const String initial = AppRoutes.searchScreen;


  static final pages = [
    GetPage(name:  AppRoutes.home, page: ()=> const HomeScreen())

  ]; 
}
