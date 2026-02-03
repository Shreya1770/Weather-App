class Weather{
  final String cityname;
  final String description;
  final double temperature;
  final double windspeed;
  final int humidity;
  final int sunrise;
  final int sunset;

  Weather({required this.cityname,
  required this.description,
  required this.temperature,
  required this.windspeed,
  required this.humidity,
  required this.sunrise,
  required this.sunset,
});

factory Weather.fromJson(Map<String,dynamic> json){
  return Weather(
    cityname: json['name'],
   description: json['weather']['description'],
    temperature: json['main']['temp']-273.15, 
    windspeed: json['wind']['speed'],
     humidity: json['main']['humidity'],
      sunrise: json['sys']['sunrise'],
       sunset: json['sys']['sunset'],
       );
}
  
}