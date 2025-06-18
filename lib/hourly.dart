import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather/helpers.dart';

class HourlyForecastToday extends StatefulWidget {
  const HourlyForecastToday({super.key, required this.rawJson});

  final String rawJson;

  @override
  State<HourlyForecastToday> createState() => _HourlyForecastState();
}

class ForecastEntry {
  String timeStamp;
  double temp;
  double avgPrecp; // sum in mm
  int weatherCode;
  ForecastEntry(this.timeStamp, this.temp, this.avgPrecp, this.weatherCode);
}

List<List<ForecastEntry>> forecastHourly = []; // each list is day of hours
List<String> forecastDays = [];

int dayIndex = 0; // default is today's date

class _HourlyForecastState extends State<HourlyForecastToday> {
  late String selectedDate;

  void updateWeatherInfo() {
    final data = jsonDecode(widget.rawJson);
    forecastHourly.clear();
    forecastDays.clear();
    for(int i = 0; i < 4; i++) {
      List<ForecastEntry> entries = [];
      for(int j = 0; j < 24; j++) {
        int index = i * 24 + j;
        ForecastEntry entry = ForecastEntry(data["hourly"]["time"][index].toString().split("T")[1],
            data["hourly"]["temperature_2m"][index],
            data["hourly"]["precipitation"][index],
            data["hourly"]["weather_code"][index]);
        entries.add(entry);
      }
      forecastHourly.add(entries);
      String day = data["hourly"]["time"][i*24].toString().split("T")[0];
      forecastDays.add(day);
    }
    selectedDate = forecastDays.first;
  }

  Widget _renderHourlyForecast() {
    List<Widget> widgets = [];

    // render drop down
    Widget ddb = DropdownButton<String>(
      value: selectedDate,
      onChanged: (String? value) {
        setState(() {
          selectedDate = value!;
          dayIndex = forecastDays.indexOf(selectedDate);
        });
      },
      items:
      forecastDays.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
    );
    widgets.add(ddb);
    widgets.add(SizedBox(height: 16,));

    //render forecast
    for(int i = 0; i < 24; i++) {
      ForecastEntry entry = forecastHourly[dayIndex][i];
      String entryIcon = determineIcon(entry.weatherCode,false);
      Widget w = Row(spacing:5,mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(entry.timeStamp, style: TextStyle(fontSize: 25)),
        Image.asset(entryIcon),
        Text("${entry.temp} °${getUnit()}", style: TextStyle(fontSize: 30)),
        SizedBox(width: 20,),
        Row(spacing: 5, mainAxisAlignment: MainAxisAlignment.center,children: [
          SizedBox(width: 30,child: Image.asset("assets/27.png")), // rain drop icon
          Text("${entry.avgPrecp} mm")
        ],)
      ],);
      widgets.add(w);
    }
    return Column(spacing: 20, mainAxisAlignment: MainAxisAlignment.center, children: widgets,);
  }

  @override
  void initState() {
    super.initState();
    updateWeatherInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    title: Text("Hourly forecast"),
    ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _renderHourlyForecast(),
              ],
            ),
          ),
        )
    );
  }
}