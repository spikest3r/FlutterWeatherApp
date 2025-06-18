import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/data.dart';
import 'package:weather/main.dart';

class CitySelection extends StatefulWidget {
  const CitySelection({super.key});

  @override
  State<CitySelection> createState() => _CitySelectState();
}

String cityName = LocationStorage.city;
bool fahrenheit = false;

String getApiLink(String city) {
  return "https://geocoding-api.open-meteo.com/v1/search?name=$city&count=1&language=en&format=json";
}

Future<bool> fetchGeodata(String city) async {
  final url = Uri.parse(getApiLink(city));
  try {
    final response = await http.get(url); // fetch data from api
    if (response.statusCode == 200) { // if we got data
      final data = jsonDecode(response.body)["results"][0];
      LocationStorage.city = data["name"];
      LocationStorage.latitude = data["latitude"];
      LocationStorage.longitude = data["longitude"];
      LocationStorage.fahrenheit = fahrenheit;
      LocationStorage.update = true;
      LocationStorage.Save();
    } else {
      return false;
    }
  } catch(ex) {
    print(ex);
    return false;
  }
  return true; // rn empty
}

class _CitySelectState extends State<CitySelection> {
  final cityField = TextEditingController();

  @override
  void initState() {
    super.initState();
    cityField.text = cityName; // Set initial text
  }

  @override
  void dispose() {
    cityField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Settings"),
        ),
        body: Center(child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(width: 200, child:
      TextField(
        controller: cityField,
        decoration: InputDecoration(
          labelText: "Enter city",
          border: OutlineInputBorder()
        ),
        onChanged: (text) {
          cityName = text;
        },

      ),),
      SizedBox(height: 20,),
      SizedBox(width: 200, child:CheckboxListTile(title: Text('Use Fahrenheit'), value: fahrenheit, onChanged: (value) {setState(() {
        fahrenheit = value!;
      });})),
      SizedBox(height: 20,),
      ElevatedButton(onPressed: () {
        if(fetchGeodata(cityName) == false) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error!"),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          Navigator.pop(context);
        }
      }, child: const Text("Save")),
    ],
    )));
  }
}
