import 'dart:ffi';

import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tuneyourmindtym/TYMNotificationsHelper.dart';
import 'package:tuneyourmindtym/features/alarms/TYMNewAlarm.dart';
import 'package:tuneyourmindtym/tymlocaldb/TYMAlarmsDb.dart';

import '../../shared/TYMColors.dart';

class TYMAlarms extends StatefulWidget {
  const TYMAlarms({Key? key}) : super(key: key);

  @override
  State<TYMAlarms> createState() => _TYMAlarmsState();
}

class _TYMAlarmsState extends State<TYMAlarms> {
  DateTime remTime = DateTime(2016, 5, 10, 22, 35);
  bool isSwitched = false;
  var textValue = 'Switch is OFF';
  Future<List<MyAlarms>> _alarmData = TYMAlarmsDb.instance.getTymAlarms();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        child:Container(
          height: double.infinity,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 80,),
                      Text(
                        "Alarms",
                        style: TextStyle(
                            color: Palette.tymDark,
                            fontSize: 36,
                            fontFamily: 'Futura',
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: OutlinedButton(onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context)=>TYMNewAlarm()
                              )
                          );
                        },
                          child: Text(
                            "Add new Alarm",
                            style: TextStyle(
                                fontFamily: 'Futura',
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 16
                            ),
                          ),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                      side: BorderSide(color: Colors.red)
                                  )
                              )
                          ),
                        ),
                      ),
                    FutureBuilder<List<MyAlarms>> (
                        future: _alarmData,
                        builder: (BuildContext context, AsyncSnapshot<List<MyAlarms>> snapshot) {
                          if(!snapshot.hasData){
                            return CircularProgressIndicator(color: Palette.tymDark,);
                          }
                          return snapshot.data!.isEmpty
                              ? Center(child: Text("You haven\'t set any alarms",style: TextStyle(fontFamily: 'Futura',fontSize: 20),),)
                              : ListView(
                            shrinkWrap: true,
                            children: snapshot.data!.map((tymalarms){
                              return Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  onTap: (){
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context){
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              ListTile(
                                                leading: new FaIcon(FontAwesomeIcons.trash),
                                                title: new Text('Delete'),
                                                onTap: () async{
                                                  await TYMAlarmsDb.instance.deleteAlarm(tymalarms.id);
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    _alarmData = TYMAlarmsDb.instance.getTymAlarms();
                                                  });
                                                },
                                              ),
                                              ListTile(
                                                leading: new FaIcon(FontAwesomeIcons.close),
                                                title: new Text('Close'),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  iconColor: Colors.black,
                                  leading: FaIcon(FontAwesomeIcons.bell,size: 30,),
                                  title: Text(tymalarms.notifTime,overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, fontFamily: 'Futura'),),
                                  subtitle: Text(tymalarms.notifBody,style: TextStyle(fontSize: 14, fontFamily: 'Futura'),),
                                ),
                                decoration: BoxDecoration(
                                    color: Palette.kToDark.shade100.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Palette.tymDark.withOpacity(0.5)
                                    )
                                ),
                              );
                            }).toList(),
                          );
                        }
                    ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }
    (context as Element).visitChildren(rebuild);
  }



  // void toggleSwitch(bool value) {
  //
  //   if(isSwitched == false)
  //   {
  //     setState(() {
  //       isSwitched = true;
  //       textValue = 'Switch Button is ON';
  //     });
  //     print('Switch Button is ON');
  //   }
  //   else
  //   {
  //     setState(() {
  //       isSwitched = false;
  //       textValue = 'Switch Button is OFF';
  //     });
  //     print('Switch Button is OFF');
  //   }
  // }
}
