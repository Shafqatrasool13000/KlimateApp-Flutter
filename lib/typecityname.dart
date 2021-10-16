import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChangeCityName extends StatelessWidget {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: Text('Enter City Name'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'images/white_snow.png',
              ),
              fit: BoxFit.cover),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: 250,
                  child: Divider(
                    thickness: 2,
                    color: Colors.red,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _controller,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'City',
                      hintText: 'Enter Your City  Name',
                    ),
                  ),
                ),
                FlatButton(
                  child: Text(
                    'Get Weather',
                    style: TextStyle(),
                  ),
                  color: Colors.red,
                  onPressed: () {
                    Navigator.pop(
                        context, {'intro': _controller.text.toString()});
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
