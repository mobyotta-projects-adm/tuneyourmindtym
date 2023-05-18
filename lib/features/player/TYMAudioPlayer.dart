import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import '../../shared/TYMColors.dart';

class TYMAudioPlayer extends StatefulWidget {
  final String coverArtUrl;
  final String songUrl;
  final String songTitle;
  final String songDesc;
  final AudioPlayer audioPlayer;
  final String songId;
  const TYMAudioPlayer({Key? key, required this.coverArtUrl, required this.songUrl, required this.songTitle, required this.songDesc, required this.audioPlayer, required this.songId}) : super(key: key);

  @override
  State<TYMAudioPlayer> createState() => _TYMAudioPlayerState();
}

class _TYMAudioPlayerState extends State<TYMAudioPlayer> {

  bool _isPlaying = false;
  Duration _duration = const Duration();
  Duration _position = const Duration();

  @override
  void initState() {
    playSongNow();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                          child: FadeInImage(
                            placeholder: AssetImage("assets/tymappicon.png"),
                            image: NetworkImage(widget.coverArtUrl), fit: BoxFit.cover,)),
                      SizedBox(height: 20,),
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.songTitle,
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'Futura',
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              widget.songDesc,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Futura',
                              ),
                            ),
                          ],
                        )
                      ),
                      SizedBox(height: 10,),
                      Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 5),
                      child: Row(
                        children: [
                          Text(
                              "${_position.inMinutes.remainder(60)}:${(_position.inSeconds.remainder(60).toString().padLeft(2, '0'))}",
                            style: TextStyle(
                              fontFamily: 'Futura'
                            ),
                          ),
                          Expanded(
                              child: Slider(
                                  value: _position.inSeconds.toDouble(),
                                  max: _duration.inSeconds.toDouble(),
                                  min: const Duration(microseconds: 0).inSeconds.toDouble(),
                                  activeColor: Palette.tymLight,
                                  inactiveColor: Palette.tymDark,
                                  thumbColor: Palette.tymLight,
                                  onChanged: (value){
                                    setState(() {
                                      changeToSeconds(value.toInt());
                                      value = value;
                                    });
                                  },
                              )
                          ),

                          Text(
                              "${(_duration-_position).inMinutes.remainder(60)}:${((_duration-_position).inSeconds.remainder(60).toString().padLeft(2, '0'))}",
                            style: TextStyle(
                                fontFamily: 'Futura'
                            ),
                          ),
                        ],
                      ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(45, 16, 45, 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: (){
                                  setState(() {
                                    playSongNow();
                                  });
                                },
                                padding: EdgeInsets.zero,
                                icon: FaIcon(FontAwesomeIcons.redo)),
                            IconButton(
                                onPressed: (){
                                  setState(() {

                                    if(_isPlaying){
                                      widget.audioPlayer.pause();
                                    } else {
                                      widget.audioPlayer.play();
                                    }
                                    _isPlaying = !_isPlaying;
                                  });
                                },
                                padding: EdgeInsets.zero,
                                icon:
                                _isPlaying ? FaIcon(
                                  FontAwesomeIcons.pause,size: 50,) : FaIcon(FontAwesomeIcons.play,size: 50,)),
                            IconButton(
                                onPressed: (){
                                  setState(() {
                                    widget.audioPlayer.stop();
                                    _isPlaying = false;
                                    _position = Duration(microseconds: 0);
                                  });
                                },
                                padding: EdgeInsets.zero,
                                icon: FaIcon(FontAwesomeIcons.stop)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 42, 16, 16),
                    child: IconButton(
                      onPressed: (){
                        widget.audioPlayer.dispose();
                        Navigator.pop(context);
                      },
                      icon: FaIcon(FontAwesomeIcons.arrowLeft),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void playSongNow() {
   try{
     widget.audioPlayer.setAudioSource(
         AudioSource.uri(
             Uri.parse(widget.songUrl),
           tag: MediaItem(
             // Specify a unique ID for each media item:
             id: widget.songId,
             title: widget.songTitle,
             artUri: Uri.parse(widget.coverArtUrl),
           ),
         )
     );
     widget.audioPlayer.play();
     _isPlaying = true;
   } on Exception {
     print("Cannot play song");
   }
   widget.audioPlayer.durationStream.listen((d) {
     setState(() {
       _duration = d!;
     });
   });

    widget.audioPlayer.positionStream.listen((p) {
      setState(() {
        _position = p;
      });
    });
  }

  void changeToSeconds(int seconds){
    Duration _duration = Duration(seconds: seconds);
    widget.audioPlayer.seek(_duration);
  }
}
