import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xffE3E3ED),
        child: StreamBuilder(
            stream: _myStream(),
            builder: (BuildContext context,AsyncSnapshot snapShot){
              if(!snapShot.hasData){
                return Center(
                  child: new Text('loading ...'),
                );
              }
          return new Stack(
            alignment: Alignment.center,
            children: [
              new Container(
                width: double.infinity,
                height: double.infinity,
                color: Color(0xff2c3143),
              ),
              new Container(
                width: 350,
                height: 350,
                alignment: Alignment.center,
                child: new Text(_currentTime(),style: new TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.w600
                ),),
              ),
              new CircularPercentIndicator(
                radius: 240.0,
                lineWidth: 6.0,
                percent: snapShot.data,
                backgroundColor: Colors.transparent,
                progressColor: Colors.green,
                animation: true,
                animateFromLastPercent: true,
              )

            ],
          );
        })
      ),
    );
  }

  String _currentTime() {
    String hour=DateTime.now().hour.toString().padLeft(2,"0");
    String minute=DateTime.now().minute.toString().padLeft(2,"0");
    String second=DateTime.now().second.toString().padLeft(2,"0");
    return "$hour : $minute : $second";
  }

 Stream _myStream() async*{
    yield* Stream.periodic(Duration(milliseconds: 500),(int){
//     return DateTime.now().second/60;
    return (DateTime.now().second*1000+DateTime.now().millisecond)/
        (1000*60);
    });
 }
}
