import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  const WeatherCard({super.key, required this.weather});

  String formetTime(int timestemp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestemp * 1000);
    return DateFormat('hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final desc = weather.description.toLowerCase();
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          
          width: double.infinity,
          decoration: BoxDecoration(color: Color.fromARGB(193, 255, 255, 255),
          borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              
              
              Lottie.asset(
                desc.contains('rain')
                    ? 'assets/rain.json'
                    : desc.contains('clear')
                    ? 'assets/sunny.json'
                    :desc.contains('snow')
                    ?'assets/snowfall.json'
                    : 'assets/cloudy.json',
              ),
              Text(
                weather.cityname,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 15),

              Text(
                "${weather.temperature.toStringAsFixed(1)}°C",
                style: Theme.of(
                  context,
                ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(Icons.wb_sunny_outlined, color: Colors.orange),
                      Text(
                        'Sunrise',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        formetTime(weather.sunrise),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Icon(Icons.nights_stay_outlined, color: Colors.purple),
                      Text(
                        'Sunset',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        formetTime(weather.sunset),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),

              Text(
                'Wind:${weather.windspeed}m/s',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Humidity:${weather.humidity}%',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
