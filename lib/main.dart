import 'dart:ffi';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:musicplayer/Splash.dart';

void main() => runApp(MaterialApp(
  home: Splash(),
),);




class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
AudioPlayer _audioPlayer = AudioPlayer();
bool playing = false;
String currenttime = "00.00";
String maxtime = "00.00";
String name="SONG TITLE";
double totaltime=0.0;
double totcurrtime = 0.0;
var songs;
Duration _duration = new Duration();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _audioPlayer.onAudioPositionChanged.listen((Duration duration){

      setState(() {
        currenttime = duration.toString().split(".")[0];
        currenttime = currenttime.substring(currenttime.indexOf(':')+1);
        totcurrtime = double.parse(currenttime.substring(0,currenttime.indexOf(':')))*60 + double.parse(currenttime.substring(currenttime.indexOf(':')+1));
      });
    });

    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        maxtime = duration.toString().split('.')[0];
        maxtime = maxtime.substring(maxtime.indexOf(':')+1);
        totaltime = double.parse(maxtime.substring(0,maxtime.indexOf(':')))*60 + double.parse(maxtime.substring(maxtime.indexOf(':')+1));
      });
    });

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.grey[200], Colors.teal[200]],
        )
      ),


      child: Scaffold(
        backgroundColor: Colors.transparent,


        appBar: AppBar(
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(40.0), right: Radius.zero),
          ),
          title: Text(
            'Music',
                style: TextStyle(
              color: Colors.grey[500],
                  fontSize: 20.0,
                  letterSpacing: 30.0,
          ),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[200],
          bottomOpacity: 0.0,
        ),


        body: Stack(
          children: <Widget>[

            Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[


              Center(
                child: Container(
                  //margin: EdgeInsets.symmetric(horizontal: 100.0),
                  // alignment: Alignment.center,
                  height: MediaQuery.of(context).size.width/2.2,
                  width: MediaQuery.of(context).size.width/2.2,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('asset/music.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-10,-10),
                          blurRadius: 30.0,
                          spreadRadius: 5,
                        ),
                        BoxShadow(color: Colors.grey[700],
                          blurRadius: 20.0,
                          offset: Offset(10.0, 10.0),
                        )
                      ]
                  ),
                ),
              ),//Image
              SizedBox(height: 45.0,),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "$name",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontFamily: 'Rajdhani-Regular.ttf',
                    letterSpacing: 0.0,
                  ),
                ),
              ),//song_name
              SizedBox(height: 5.0,),


              Text(
                'SINGER & ALBUM',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.red[900],
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Rajdhani-Regular.ttf',
                  fontWeight: FontWeight.bold,
                ),
              ),//singer
              SizedBox(height: 60.0,),


              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [Colors.grey.withOpacity(0.0), Colors.black54],
                      stops: [0.95, 1.0],
                    ),
                    /*boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        //offset: Offset(-4,-4),
                        blurRadius: 10.0,
                        spreadRadius: -10,
                      ),
                      BoxShadow(color: Colors.grey[700],
                        //blurRadius: 15.0,
                        //spreadRadius: -5,
                        //offset: Offset(4.0, 4.0),
                      )
                    ]*/
                ),

                child: FlatButton(
                  color: Colors.transparent,
                  onPressed: () {
                    print(_audioPlayer.playerId);

                    if(playing)
                    {
                      _audioPlayer.pause();
                      setState(() {
                        playing = false;
                      });
                    }
                    else
                    {
                      _audioPlayer.resume();
                      setState(() {
                        playing = true;
                      });
                    }
                  },
                  child: Icon(playing?
                  Icons.pause : Icons.play_arrow,
                    color: Colors.grey[600],
                    size: 40.0,

                  ),
                  padding: EdgeInsets.all(10.0),
                  shape: CircleBorder(
                  ),
                ),
              ),//play_pause
              SizedBox(height: 20.0,),

               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.white70,
                  value: (totcurrtime==totaltime)?1.0:(totcurrtime/totaltime),
                ),
              ),//progress indicator



              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(

                    "$currenttime",
                    style: TextStyle(
                        fontSize: 20.0
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(" | ", style: TextStyle(
                    fontSize: 30.0, color: Colors.red[600],
                  ),
                  ),

                  Text(
                    "$maxtime",
                    style: TextStyle(
                        fontSize: 20.0
                    ),
                    textAlign: TextAlign.end,
                  ),

                ],

              ),//song timer
              //search_button
            ],
          ),
            SizedBox(height: 20.0,),

            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
                //alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-3,-3),
                        blurRadius: 12.0,
                        spreadRadius: 1,
                      ),
                      BoxShadow(color: Colors.grey[700],
                        blurRadius: 15.0,
                        offset: Offset(4.0, 4.0),
                      )
                    ]
                ),

                child: IconButton(
                  icon: Icon(Icons.search,
                    size: 30.0,
                    color: Colors.grey[600],
                  ),
                  onPressed: () async{
                    String filepath = await FilePicker.getFilePath();
                    int status = await _audioPlayer.play(filepath, isLocal: true);
                    name = filepath.split('/').last;
                    if(status == 1)
                    {
                      setState(() {
                        playing = true;
                      });
                    }
                  },
                ),
              ),
            )//search button
          ],
        ),
      ),
    );
  }
}


