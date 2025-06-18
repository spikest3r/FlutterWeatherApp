import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/citySelect.dart';
import 'dart:convert'; // for jsonDecode
import 'package:weather/data.dart';
import 'package:weather/helpers.dart';
import 'package:weather/hourly.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  final String title = "Weather";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

final String defaultIcon = "assets/1.png";

String getApiLink(double latitude, double longitude) {
  final String apiWeatherLink =
      "https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&daily=sunset,sunrise,weather_code,"
      "precipitation_sum,temperature_2m_max,temperature_2m_min&hourly=weather_code,precipitation,visibility,temperature_2m,relative_humidity_2m"
      "&current=temperature_2m,relative_humidity_2m,is_day,weather_code,precipitation&timezone=auto&forecast_days=4${getUnit() == "F" ? "&temperature_unit=fahrenheit" : ""}";
  return apiWeatherLink;
}

class ForecastEntry {
  String dateStamp;
  double tempMin;
  double tempMax;
  double avgPrecp; // sum in mm
  int weatherCode;
  ForecastEntry(this.dateStamp, this.tempMin, this.tempMax, this.avgPrecp, this.weatherCode);
}

double tempToday = 0;
int humidityToday = 0;
double precipitationToday = 0;
String sunriseToday = "";
String sunsetToday = "";
List<ForecastEntry> forecast3days = [];

String city = "";
String iconPath = defaultIcon;
String rawJsonData = "";

Future<String> fetchWeather() async {
  final url = Uri.parse(getApiLink(LocationStorage.latitude, LocationStorage.longitude));
  try {
    final response = await http.get(url); // fetch data from api
    if (response.statusCode == 200) { // if we got data
      rawJsonData = response.body;
      return rawJsonData;
    } else {
      return "error";
    }
  } catch(ex) {
    print(ex);
    return "error";
  }
}

Widget _renderForecast() { // todo: add date display
  List<Widget> widgets = [];
  for(int i = 0; i < 3; i++) {
    ForecastEntry entry = forecast3days[i+1];
    String entryIcon = determineIcon(entry.weatherCode,false);
    Widget w = Column(spacing:5,mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(entry.dateStamp),
      Image.asset(entryIcon),
      Text("Max ${entry.tempMax} °${getUnit()}"),
      Text("Min ${entry.tempMin} °${getUnit()}"),
      Row(spacing: 5, mainAxisAlignment: MainAxisAlignment.center,children: [
        SizedBox(width: 30,child: Image.asset("assets/27.png")), // rain drop icon
        Text("${entry.avgPrecp} mm")
      ],)
    ],);
    widgets.add(w);
  }
  return Row(spacing: 20, mainAxisAlignment: MainAxisAlignment.center, children: widgets,);
}

class _MyHomePageState extends State<MyHomePage>{
  bool errorState = false;
  bool loaded = false;

  Future<void> updateWeatherInfo() async {
    await LocationStorage.Load();
    String rawJson = await fetchWeather();
    if(rawJson == "error") {
      errorState = true;
      print("error net");
      return;
    }
    errorState = false;
    loaded = true;
    final data = jsonDecode(rawJson);
    print("load weather info");
    setState(() {
      tempToday = data["current"]["temperature_2m"];
      humidityToday = data["current"]["relative_humidity_2m"];
      precipitationToday = data["current"]["precipitation"];
      sunriseToday = data["daily"]["sunrise"][0].toString().split("T")[1]; // 0 is today
      sunsetToday = data["daily"]["sunset"][0].toString().split("T")[1];
      iconPath = determineIcon(data["current"]["weather_code"], data["current"]["is_day"] == 0);
      // forecast data
      forecast3days.clear();
      for(int i = 0; i < 4; i++) { // skip zero here because we skip forecast entry for today
        ForecastEntry entry = ForecastEntry(data["daily"]["time"][i],
            data["daily"]["temperature_2m_min"][i],
            data["daily"]["temperature_2m_max"][i],
            data["daily"]["precipitation_sum"][i],
            data["daily"]["weather_code"][i]);
        print(entry.weatherCode);
        forecast3days.add(entry);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    print("Updating weather");
    updateWeatherInfo();
  }

  @override
  Widget build(BuildContext context) {
    if(LocationStorage.update) {
      LocationStorage.update = false;
      print("Updating weather build()");
      updateWeatherInfo();
    }
    if(errorState || !loaded) {
      print("$loaded $errorState");
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(child: Text(errorState ? "Network error" : "Loading...")));
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(LocationStorage.city),
            Image.asset(iconPath),
            Text("$tempToday °${getUnit()}", style: TextStyle(fontSize: 48),),
            Text("Relative humidity: $humidityToday%"),
            Text("Precipitation: $precipitationToday%"),
            Text("Sunrise: $sunriseToday"),
            Text("Sunset: $sunsetToday"),
            SizedBox(height: 16,), // spacing
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HourlyForecastToday(rawJson: rawJsonData,)));
            }, child: const Text("Hourly forecast")),
            SizedBox(height: 16,), // spacing
            Text("3 day forecast", style: TextStyle(fontSize: 30)),
            SizedBox(height: 8,), // spacing
            _renderForecast(), // forecast as row of cols
            SizedBox(height: 16,), // spacing
            ElevatedButton(onPressed: (){
              updateWeatherInfo();
            }, child: const Text("Reload")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CitySelection())).then((_) => setState(() {updateWeatherInfo();}));
      }, child: const Icon(Icons.settings)),
    );
  }
}
