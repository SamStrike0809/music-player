import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:musicplayer/main.dart';

void main() => runApp(MaterialApp(
  home: Splash(),
));


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 3,),
            () {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => MyApp(),
    ),
    );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[

          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('asset/background.png'),
                fit: BoxFit.cover,
              )
            )
          ),//for music

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Center(
                child: Container(
                  //alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 200),
                  padding: EdgeInsets.fromLTRB(30.0, 7.0, 30.0, 7.0),
                  child: Text(
                    'MUSIC',
                    style: TextStyle(
                      fontFamily: 'asset/Rajdhani-Bold.tff',
                      letterSpacing: 10.0,
                      fontSize: 30.0,
                      color: Colors.red[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    border: Border.all(
                      color: Colors.red[800],
                      width: 3.0,
                    )
                  )
                ),
              ),
            ],
          ),//for circle

          Center(
            child:  Container(
              padding: EdgeInsets.only(bottom: 10),
              alignment: Alignment.bottomCenter,
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey[900],
              ),
            ),
          )
          ],
      )
          );
  }
}

