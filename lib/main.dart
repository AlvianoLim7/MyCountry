import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MainAppState();
}

class _MainAppState extends State<MyApp> {
  TextEditingController countryName = TextEditingController();
  String name = "Country Name: No Data";
  String currencyName = "Currency Name: No Data";
  String currencyCode = "Currency Code: No Data";
  String capital = "Capital: No Data";
  Uri image1 = Uri.parse(
      'https://raw.githubusercontent.com/LeonKings/Gambar/main/download.png');
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: const Text("Country")),
        body: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Padding(padding: EdgeInsets.all(15)),
            const Text(
              "My Country",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Padding(padding: EdgeInsets.all(15)),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
                width: 300,
                child: TextField(
                  controller: countryName,
                  decoration: InputDecoration(
                      hintText: 'Input Country Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                )),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(onPressed: _getCountry, child: const Text("Search")),
            Container(
              height: 200,
              width: 300,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Image(
                    width: 64,
                    image: NetworkImage('$image1'),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: const TextStyle(fontSize: 15)),
                      Text(capital, style: const TextStyle(fontSize: 15)),
                      Text(currencyName, style: const TextStyle(fontSize: 15)),
                      Text(currencyCode, style: const TextStyle(fontSize: 15)),
                    ],
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  Future<void> _getCountry() async {
    String countryname = countryName.text;
    var apiid = "TzI/knF49j8T5jVYMMAn5g==uFTQ7TI9966hzgis";
    var url =
        Uri.parse('https://api.api-ninjas.com/v1/country?name=$countryname');
    var response = await http.get(url, headers: {'X-Api-Key': apiid});
    var rescode = response.statusCode;
    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      if(parsedJson.toString() == '[]'){
        setState(() {
        name = 'Country Name: No Data';
        currencyName = 'Currency Name: No Data';
        currencyCode = 'Currency Code: No Data';
        capital = 'Capital: No Data';
        image1 = Uri.parse(
            'https://raw.githubusercontent.com/LeonKings/Gambar/main/download.png');
      });
      }else{
        setState(() {
        var names = parsedJson[0]['name'];
        var capitals = parsedJson[0]['capital'];
        var currencycode = parsedJson[0]['currency']['code'];
        var currencyname = parsedJson[0]['currency']['name'];
        var iso = parsedJson[0]['iso2'];
        name = 'Country Name: $names';
        currencyName = 'Currency Name: $currencyname';
        currencyCode = 'Currency Code: $currencycode';
        capital = 'Capital: $capitals';
        image1 = Uri.parse('https://flagsapi.com/$iso/shiny/64.png');
      });
      }
    } else {
      setState(() {
        name = 'No Data';
        currencyName = 'No Data';
        currencyCode = 'No Data';
        capital = 'No Data';
        image1 = Uri.parse(
            'https://raw.githubusercontent.com/LeonKings/Gambar/main/download.png');
      });
    }
  }
}
