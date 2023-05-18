import 'package:animate_gradient/animate_gradient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/animate.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tuneyourmindtym/shared/TYMStringExt.dart';

import '../../shared/TYMColors.dart';
import '../player/TYMAudioPlayer.dart';

class TYMHome extends StatefulWidget {
  const TYMHome({Key? key}) : super(key: key);

  @override
  State<TYMHome> createState() => _TYMHomeState();
}

final tymUser = FirebaseAuth.instance.currentUser!;

class _TYMHomeState extends State<TYMHome> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  Query dbRefMed = FirebaseDatabase.instance.ref().child('songs').orderByChild('category').equalTo("meditation");
  Query dbRefSleep = FirebaseDatabase.instance.ref().child('songs').orderByChild('category').equalTo("sleep");
  Query dbRefSync = FirebaseDatabase.instance.ref().child('songs').orderByChild('category').equalTo("sync");

  @override
  void initState() {
    controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    super.initState();
  }
  var tuserimg = tymUser.photoURL==null ? AssetImage('assets/tymusericon.png') : NetworkImage(tymUser.photoURL!,) as ImageProvider;
  var splittedGreet = tymUser.email?.split("@");
  int _screenNo = 0;
  @override
  Widget build(BuildContext context) {
    if(_screenNo==0){
      return Scaffold(
        body: AnimateGradient(
          primaryBegin: Alignment.topLeft,
          primaryEnd: Alignment.centerLeft,
          secondaryBegin: Alignment.bottomRight,
          secondaryEnd: Alignment.centerRight,
          primaryColors: [
            Palette.tymDark.withOpacity(0.9),
            Palette.kToDark.shade100,
            Palette.tymLight
          ],
          secondaryColors: [
            Palette.tymLight,
            Palette.kToDark.shade100,
            Palette.tymDark.withOpacity(0.9)
          ],
          duration: Duration(seconds: 4),
          animateAlignments: true,
          child: Container(
            height: double.infinity,
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30,),
                      TextButton(
                          onPressed: (){
                            setState(() {
                              _screenNo=1;
                            });
                          },
                          child: Text(
                            "MEDITATE",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 34,
                                fontFamily: 'Futura',
                            ),
                          )
                      ).animate(
                      ).fadeIn(curve: Curves.easeIn,delay: 1500.ms),
                      SizedBox(height: 80,),
                      TextButton(
                          onPressed: (){
                            setState(() {
                              _screenNo=2;
                            });
                          },
                          child: Text(
                            "SLEEP",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 34,
                                fontFamily: 'Futura',
                                fontWeight: FontWeight.w500
                            ),
                          )
                      ).animate(
                      ).fadeIn(curve: Curves.easeIn,delay: 2000.ms),
                      SizedBox(height: 80,),
                      TextButton(
                          onPressed: (){
                            setState(() {
                              _screenNo=3;
                            });
                          },
                          child: Text(
                            "SYNCHRONIZE",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 34,
                                fontFamily: 'Futura',
                            ),
                          )
                      ).animate(
                      ).fadeIn(curve: Curves.easeIn,delay: 2500.ms),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 58, 16, 32),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Palette.kToDark.shade800,
                          radius: 25,
                          backgroundImage: tuserimg,
                        ),
                        SizedBox(width: 10,),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Greetings!",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Futura',
                                  color: Palette.kToDark.shade50
                              ),
                            ),
                            SizedBox(height: 2,),
                            Text(
                              ""+splittedGreet![0].capitalize(),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Futura',
                                  fontWeight: FontWeight.w400,
                                  color: Palette.kToDark.shade50,
                                  height: 1.1
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    else if(_screenNo==1){
      return WillPopScope(
        onWillPop: () async{
          return false;
        },
        child: Scaffold(
          body: AnimateGradient(
            primaryBegin: Alignment.topLeft,
            primaryEnd: Alignment.centerLeft,
            secondaryBegin: Alignment.bottomRight,
            secondaryEnd: Alignment.centerRight,
            primaryColors: [
              Palette.tymDark.withOpacity(0.9),
              Palette.kToDark.shade100,
              Palette.tymLight
            ],
            secondaryColors: [
              Palette.tymLight,
              Palette.kToDark.shade100,
              Palette.tymDark.withOpacity(0.9)
            ],
            duration: Duration(seconds: 4),
            animateAlignments: true,
            child: Container(
              height: double.infinity,
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 128, 16, 32),
                      child: FirebaseAnimatedList(
                        query: dbRefMed,
                        itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation anim, int index){
                          Map mediSongs = snapshot.value as Map;
                          mediSongs['key'] = snapshot.key;
                           return listItem(songsList: mediSongs);
                        },
                        defaultChild: CircularProgressIndicator(
                          color: Palette.tymDark,
                        ),
                      ),
                    )
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 58, 16, 32),
                      child: Row(
                        children: [
                          IconButton(onPressed: (){
                            setState(() {
                              _screenNo=0;
                            });
                          }, icon: FaIcon(FontAwesomeIcons.arrowLeft),color: Palette.tymDark,),
                          SizedBox(width: 2,),
                          Text(
                            "Meditate",
                            style: TextStyle(
                                color: Palette.tymDark,
                                fontSize: 28,
                                fontFamily: 'Futura',
                                fontWeight: FontWeight.w500
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    else if(_screenNo==2){
      return WillPopScope(
        onWillPop: () async{
          return false;
        },
        child: Scaffold(
          body: AnimateGradient(
            primaryBegin: Alignment.topLeft,
            primaryEnd: Alignment.centerLeft,
            secondaryBegin: Alignment.bottomRight,
            secondaryEnd: Alignment.centerRight,
            primaryColors: [
              Palette.tymDark.withOpacity(0.9),
              Palette.kToDark.shade100,
              Palette.tymLight
            ],
            secondaryColors: [
              Palette.tymLight,
              Palette.kToDark.shade100,
              Palette.tymDark.withOpacity(0.9)
            ],
            duration: Duration(seconds: 4),
            animateAlignments: true,
            child: Container(
              height: double.infinity,
              child: Stack(
                children: [
                  Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 128, 16, 32),
                        child: FirebaseAnimatedList(
                          query: dbRefSleep,
                          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation anim, int index){
                            Map mediSongs = snapshot.value as Map;
                            mediSongs['key'] = snapshot.key;
                            return listItem(songsList: mediSongs);
                          },
                          defaultChild: CircularProgressIndicator(
                            color: Palette.tymDark,
                          ),
                        ),
                      )
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 58, 16, 32),
                      child: Row(
                        children: [
                          IconButton(onPressed: (){
                            setState(() {
                              _screenNo=0;
                            });
                          }, icon: FaIcon(FontAwesomeIcons.arrowLeft),color: Palette.tymDark,),
                          SizedBox(width: 2,),
                          Text(
                            "Sleep",
                            style: TextStyle(
                                color: Palette.tymDark,
                                fontSize: 28,
                                fontFamily: 'Futura',
                                fontWeight: FontWeight.w500
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    else if(_screenNo==3){
      return WillPopScope(
        onWillPop: () async{
          return false;
        },
        child: Scaffold(
          body: AnimateGradient(
            primaryBegin: Alignment.topLeft,
            primaryEnd: Alignment.centerLeft,
            secondaryBegin: Alignment.bottomRight,
            secondaryEnd: Alignment.centerRight,
            primaryColors: [
              Palette.tymDark.withOpacity(0.9),
              Palette.kToDark.shade100,
              Palette.tymLight
            ],
            secondaryColors: [
              Palette.tymLight,
              Palette.kToDark.shade100,
              Palette.tymDark.withOpacity(0.9)
            ],
            duration: Duration(seconds: 4),
            animateAlignments: true,
            child: Container(
              height: double.infinity,
              child: Stack(
                children: [
                  Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 128, 16, 32),
                        child: FirebaseAnimatedList(
                          query: dbRefSync,
                          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation anim, int index){
                            Map mediSongs = snapshot.value as Map;
                            mediSongs['key'] = snapshot.key;
                            return listItem(songsList: mediSongs);
                          },
                          defaultChild: CircularProgressIndicator(
                            color: Palette.tymDark,
                          ),
                        ),
                      )
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 58, 16, 32),
                      child: Row(
                        children: [
                          IconButton(onPressed: (){
                            setState(() {
                              _screenNo=0;
                            });
                          }, icon: FaIcon(FontAwesomeIcons.arrowLeft),color: Palette.tymDark,),
                          SizedBox(width: 2,),
                          Text(
                            "Synchronize",
                            style: TextStyle(
                                color: Palette.tymDark,
                                fontSize: 28,
                                fontFamily: 'Futura',
                                fontWeight: FontWeight.w500
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return Scaffold(
      body: AnimateGradient(
        primaryBegin: Alignment.topLeft,
        primaryEnd: Alignment.centerLeft,
        secondaryBegin: Alignment.bottomRight,
        secondaryEnd: Alignment.centerRight,
        primaryColors: [
          Palette.tymDark.withOpacity(0.9),
          Palette.kToDark.shade100,
          Palette.tymLight
        ],
        secondaryColors: [
          Palette.tymLight,
          Palette.kToDark.shade100,
          Palette.tymDark.withOpacity(0.9)
        ],
        duration: Duration(seconds: 4),
        animateAlignments: true,
        child: Container(
          height: double.infinity,
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30,),
                    TextButton(
                        onPressed: (){
                          setState(() {
                            _screenNo=1;
                          });
                        },
                        child: Text(
                          "MEDITATE",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontFamily: 'Futura',
                              fontWeight: FontWeight.w500
                          ),
                        )
                    ).animate(
                    ).fadeIn(curve: Curves.easeIn,delay: 1800.ms),
                    SizedBox(height: 30,),
                    TextButton(
                        onPressed: (){
                          setState(() {
                            _screenNo=2;
                          });
                        },
                        child: Text(
                          "SLEEP",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontFamily: 'Futura',
                              fontWeight: FontWeight.w500
                          ),
                        )
                    ).animate(
                    ).fadeIn(curve: Curves.easeIn,delay: 2200.ms),
                    SizedBox(height: 30,),
                    TextButton(
                        onPressed: (){
                          setState(() {
                            _screenNo=3;
                          });
                        },
                        child: Text(
                          "SYNCHRONIZE",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontFamily: 'Futura',
                              fontWeight: FontWeight.w500
                          ),
                        )
                    ).animate(
                    ).fadeIn(curve: Curves.easeIn,delay: 2600.ms),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 58, 16, 32),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Palette.kToDark.shade800,
                        radius: 25,
                        backgroundImage: tuserimg,
                      ),
                      SizedBox(width: 10,),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Greetings!",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Futura',
                                color: Palette.kToDark.shade50
                            ),
                          ),
                          SizedBox(height: 2,),
                          Text(
                            ""+splittedGreet![0].capitalize(),
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Futura',
                                fontWeight: FontWeight.w400,
                                color: Palette.kToDark.shade50,
                                height: 1.1
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listItem({required Map songsList}) {
    AudioPlayer audioPlayer = AudioPlayer();
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context)=>TYMAudioPlayer(
                  coverArtUrl: songsList['CoverUrl'],
                  songDesc: songsList['description'],
                  songUrl: songsList['songsUrl'],
                  songTitle: songsList['title'],
                  audioPlayer:audioPlayer,
                  songId: songsList.hashCode.toString() ,
                )
            )
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: getDuration(songsList['songsUrl']),
              builder: (context,snapshot){
                return Chip(
                  padding: EdgeInsets.all(2),
                  backgroundColor: Palette.tymLight,
                  label: Text(
                    snapshot.data.toString()+" MINS",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, fontFamily: 'Futura'),
                  ),
                );
              },
        initialData: "???",
        ),
            Row(
              children: [
                FadeInImage(placeholder: AssetImage("assets/tymappicon.png"), image: NetworkImage(songsList['CoverUrl']), height: 70, width: 70, fit: BoxFit.cover,),
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        songsList['title'],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, fontFamily: 'Futura'),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        songsList['description'],
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Palette.kToDark.shade100.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Palette.tymDark.withOpacity(0.5)
          )
        ),
      ),
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<String> getDuration(String url) async {
    final _audioPlayer = AudioPlayer();
    Duration? duration = await _audioPlayer.setUrl(url);
    _audioPlayer.dispose();
    return "${duration?.inMinutes.remainder(60)}:${(duration?.inSeconds.remainder(60).toString().padLeft(2, '0'))}";
  }
}
