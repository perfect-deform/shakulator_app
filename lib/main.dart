import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:sensors/sensors.dart';
import 'dart:async';

void main() => runApp(MaterialApp(home: Shak()));

class Shak extends StatefulWidget {
  @override
  _ShakState createState() => _ShakState();
}

//123123123123

class _ShakState extends State<Shak> {
  double userAcc = 0;
  bool added = false;
  double inputField = 0;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
  <StreamSubscription<dynamic>>[];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Shakulator'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: AutoSizeText(
                        '$inputField',
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: AutoSizeText(
                        'userAcc:' + userAcc.toStringAsFixed(0),
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: MaterialButton(
                color: Color(0xFF262626),
                child: AutoSizeText(
                  'PRESS',
                  style: TextStyle(
                    color: Color(0xFFD9D9D9),
                    fontSize: (32.0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    userAccelerometerEvents.listen((UserAccelerometerEvent y) {
                      print(y);
                    });
                  });
                },
              ),
            ),
          ],
        ),
        color: Colors.grey,

      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions
        .add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        if(event.y.abs()>2 && added==false){
          inputField++;
          added = true;
        }else if(event.y.abs()<1 && added==true){
          added = false;
        }
        userAcc = event.y.abs();
      });
    }));
  }


}