import 'package:flutter/material.dart';

class WeatherStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subText;
  final double w;
  final double h;

  const WeatherStat({
    super.key,
    required this.icon,
    required this.label,
    required this.subText,
    required this.w,
    required this.h,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: w * 0.07),
        SizedBox(height: h * 0.005),
        Text(label,
            style: TextStyle(
                color: Colors.white,
                fontSize: w * 0.045,
                fontWeight: FontWeight.bold)),
        Text(subText,
            style: TextStyle(color: Colors.white70, fontSize: w * 0.03)),
      ],
    );
  }
}
