import 'package:flutter/material.dart';

class HourlyForecast extends StatelessWidget {
  final double w;
  final double h;
  final double temp;
  final double temf;
  final String name;
  final IconData icon;
  const HourlyForecast(
      {super.key,
      required this.w,
      required this.h,
      required this.name,
      required this.temf,
      required this.temp,
      required this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: w * 0.02),
      width: w * 0.18,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(w * 0.05),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: h * 0.02,
          ),
          Text(name, style: TextStyle(color: Colors.white, fontSize: w * 0.03)),
          Text(temp.toString(),
              style: TextStyle(color: Colors.white, fontSize: w * 0.03)),
          Icon(icon, color: Colors.yellow, size: w * 0.07),
          Text(
            temf.toString(),
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
