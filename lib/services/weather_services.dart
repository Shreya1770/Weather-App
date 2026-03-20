import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherServices{
  final String apikey="REMOVED";
  Future<Weather> fetchweather(String cityname) async{
    final city = Uri.encodeComponent(cityname.trim());
    final url=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apikey');

    final response=await http.get(url);
    print(response.body);
    print(response.statusCode);

    if(response.statusCode==200){
      return Weather.fromJson(json.decode(response.body));
    }
    else{
      final error=json.decode(response.body);
      throw Exception(error["message"]);
    }
  }
}