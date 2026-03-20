import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widgets/weather_card.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final WeatherServices _weatherServices = WeatherServices();
  bool isloading = false;
  final TextEditingController _controller = TextEditingController();

  Weather? _weather;

  void _getweather() async {
    setState(() {
      isloading = true;
    });
    try {
      final weather = await _weatherServices.fetchweather(_controller.text);
      setState(() {
        _weather = weather;
        isloading = false;
      });
    } catch (e) {
      setState(() {
        isloading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient:
              _weather != null &&
                  _weather!.description.toLowerCase().contains('rain')
              ? LinearGradient(
                  colors: [Color(0xffcfd9df), Color(0xffe2ebf0)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : _weather != null &&
                    _weather!.description.toLowerCase().contains('clear')
              ? LinearGradient(
                  colors: [Color(0xfff83600), Color(0xfff9d423)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : LinearGradient(
                  colors: [Color.fromARGB(255, 77, 133, 230), Color(0xff04befe)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 25),
                Text(
                  'Weather App',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                TextField(
                  controller: _controller,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter the city name',
                    hintStyle: TextStyle(color: Colors.white30),
                    filled: true,
                    fillColor: const Color.fromARGB(77, 219, 207, 207),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _getweather,
                  child: Text(
                    'Get Weather',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 219, 211, 211),
                    foregroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                if (isloading)
                  Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: CircularProgressIndicator(color: Colors.white),
                  ),

                if (_weather != null && !isloading)
                  WeatherCard(weather: _weather!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
