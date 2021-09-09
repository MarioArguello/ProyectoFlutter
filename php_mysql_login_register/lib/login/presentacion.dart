import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MyApp12 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: asd(),
    );
  }
}

class asd extends StatefulWidget {
  @override
  MyProgressIndicator createState() => MyProgressIndicator();
}

class MyProgressIndicator extends State<asd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Custom Progress Indicator"),
            backgroundColor: Colors.redAccent),
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(10),
                child: CircularPercentIndicator(
                  //circular progress indicator
                  radius: 120.0, //radius for circle
                  lineWidth: 15.0, //width of circle line
                  animation:
                      true, //animate when it shows progress indicator first
                  percent:
                      70 / 100, //vercentage value: 0.6 for 60% (60/100 = 0.6)
                  center: Text(
                    "60.0%",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ), //center text, you can set Icon as well
                  footer: Text(
                    "Cargando",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                    textAlign: TextAlign.center,
                  ), //footer text
                  backgroundColor:
                      Colors.lightGreen[300], //backround of progress bar
                  circularStrokeCap: CircularStrokeCap
                      .round, //corner shape of progress bar at start/end
                  progressColor: Colors.redAccent, //progress bar color
                )),
          ],
        )));
  }
}
