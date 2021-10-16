import 'dart:convert';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:klimeticapp/constants.dart';
import 'package:klimeticapp/typecityname.dart';
import 'package:http/http.dart' as http;
import 'package:klimeticapp/uitils/utils.dart' as util;

class Climatic extends StatefulWidget {
  @override
  _ClimaticState createState() => _ClimaticState();
}

class _ClimaticState extends State<Climatic> {
  String myCityName;

  Future _getCityCallBack(BuildContext context) async {
    Map results = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ChangeCityName();
        },
      ),
    );
    if (results != null && results.containsKey('intro')) {
      setState(() {
        myCityName = results['intro'];
      });
    } else {
      return 'nothing';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              _getCityCallBack(context);
            },
          ),
        ],
        title: Text('Weather'),
      ),
      body: Stack(
        children: <Widget>[
          Image(
            image: AssetImage(
              'images/umbrella.png',
            ),
            fit: BoxFit.fill,
            width: 790,
            height: 790,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10, 12, 0.0),
            alignment: Alignment.topRight,
            child: Text(
              '${myCityName == null ? util.cityName : myCityName}',
              style: kCityName,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Image(
              image: AssetImage('images/light_rain.png'),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(50.0, 330, 80, 0.0),
            child: updateCityWidget(myCityName),
          ),
        ],
      ),
    );
  }

  Future<Map> getWeather(String cityName, String apiKey) async {
    String apiUrl =
        'https://api.openweathermap.org/data/2.5/find?q=$cityName&units=metric&appid=$apiKey';
    http.Response response = await http.get(apiUrl);
    return json.decode(response.body);
  }

  Widget updateCityWidget(String city) {
    return FutureBuilder(
      future: getWeather(
          myCityName == null ? util.cityName : myCityName, util.apiKey),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        if (snapshot.hasData) {
          Map content = snapshot.data;
          List _lottery;
          _lottery = content['list'];
          return Container(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text('${_lottery[0]['main']['temp'].toString()} °C',
                      style: kTemperatureTextStyle),
                  subtitle: Text(
                    'Humidity:${_lottery[0]['main']['humidity'].toString()}\n'
                    'Max:${_lottery[0]['main']['temp_max'].toString()} °C\n'
                    'Min:${_lottery[0]['main']['temp_min'].toString()} °C',
                    style: kWeatherCondition,
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
