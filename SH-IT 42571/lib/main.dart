import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

main() {
  runApp(MaterialApp(
    title: "Weather App",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var temperature;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  // var cordLon;
  //var cordLat;


  Future getWeather() async {
    http.Response respond = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=lagos,100265,nigeria&appid=4a9798ca681e9334a53d5efc4cf2b089'));
        var results = jsonDecode(respond.body);
    setState(() {
      this.temperature = results["main"]["temp"];
      this.description = results["weather"][0]["description"];
      this.currently = results["weather"][0]["main"];
      this.humidity = results["main"]["humidity"];
      this.windSpeed = results["wind"]["speed"];
      /*this.cordLat = results["coord"]["lat"];*/
      /*this.cordLon= results["coord"]["lon"];*/
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.cyan,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  child: Text(
                    "Currently in Lagos",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  temperature != null
                      ? temperature.toString() + "\u0000"
                      : "loading",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10.0,
                  ),
                  child: Text(
                    currently != null ? currently.toString() : "loading",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  // ListTile(
                  //   leading: FaIcon(FontAwesomeIcons.landmark),
                  //   title: Text("Coordinate"),
                  //   trailing: Text(
                  //       cordLon && cordLat != null ? cordLon : "loading"),
                  // ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometer),
                    title: Text(temperature != null
                        ? temperature.toString()
                        : "loading"),
                    trailing: Text("50\u0000"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("Weather"),
                    trailing: Text(description != null
                        ? description.toString()
                        : "loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text(
                        humidity != null ? humidity.toString() : "loading"),
                    trailing: Text("12"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Wind Speed"),
                    trailing: Text(
                        windSpeed != null ? windSpeed.toString() : "loading"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
