import 'dart:ffi';

import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tuneyourmindtym/features/alarms/TYMAlarms.dart';
import 'package:tuneyourmindtym/tymlocaldb/TYMAlarmsDb.dart';

import '../../TYMNotificationsHelper.dart';
import '../../shared/TYMColors.dart';

class TYMNewAlarm extends StatefulWidget {
  const TYMNewAlarm({Key? key}) : super(key: key);

  @override
  State<TYMNewAlarm> createState() => _TYMNewAlarmState();
}

class _TYMNewAlarmState extends State<TYMNewAlarm> {
  DateTime remTime = DateTime.now();
  TextEditingController selectedTimeController = TextEditingController();
  TextEditingController alrmLabelController = TextEditingController();

  final _addNewAlarmFormKey = GlobalKey<FormState>();
  String _dropdownValue = "Calm";
  List<String> dropDownOptions = [
    "Calm",
    "Focus",
    "Morning",
    "Relax",
  ];

  @override
  Widget build(BuildContext context) {
    int alarmId = idGenerator();
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                Form(
                  key: _addNewAlarmFormKey,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TimePickerSpinner(
                          is24HourMode: false,
                          spacing: 64.0,
                          onTimeChange: (time) {
                            setState(() {
                              remTime = time;
                            });
                          },
                        ),
                        SizedBox(height: 30,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontFamily: 'Futura',
                              color: Colors.black
                            ),
                            controller: selectedTimeController,
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: "Alarm Time",
                              floatingLabelStyle: TextStyle(
                                  color: Colors.black,
                                fontFamily: 'Futura'
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              focusedBorder: const OutlineInputBorder(),
                              hintText: formatedTime(remTime),
                              hintStyle: const TextStyle(
                                  fontFamily: 'Futura',
                                  fontSize: 24,
                                  color: Colors.black
                              ),
                              contentPadding: const EdgeInsets.all(18.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontFamily: 'Futura'
                            ),
                            controller: alrmLabelController,
                            keyboardType: TextInputType.text,
                            selectionControls: MaterialTextSelectionControls(),
                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: "What\'s this alarm for?",
                              floatingLabelStyle: TextStyle(
                                color: Colors.black
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              focusedBorder: const OutlineInputBorder(),
                              hintText: "Ex. Wakeup, Sleep",
                              hintStyle: const TextStyle(
                                  fontFamily: 'Futura',
                                  fontSize: 24,
                              ),
                              contentPadding: const EdgeInsets.all(18.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Select Sound",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Futura',
                                    fontSize: 18
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0)
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    items: dropDownOptions
                                        .map<DropdownMenuItem<String>>((String mascot) {
                                      return DropdownMenuItem<String>(
                                          child: Text(mascot), value: mascot);
                                    }).toList(),
                                    value: _dropdownValue,
                                    onChanged: dropdownCallback,
                                    iconSize: 42.0,
                                    hint: Text("Select Ringtone"),
                                    iconEnabledColor: Palette.tymDark,
                                    dropdownColor: Palette.tymLight,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Futura',
                                        fontSize: 24
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                          child: OutlinedButton(onPressed: () async{
                            //Navigator.pop(context);
                            TYMNotificationsHelper.showScheduledNotification(
                                alarmid: alarmId,
                                title: "Tune your mind",
                                body: alrmLabelController.text,
                                payload: "TYM.abs",
                                scheduledTime: remTime,
                            );
                            await TYMAlarmsDb.instance.addAlarm(
                              MyAlarms(id: alarmId, notifBody: alrmLabelController.text, notifTime: formatedTime(remTime))
                            );
                            setState(() {
                              alrmLabelController.clear();
                            });
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TYMAlarms()));
                          },
                            child: Text(
                              "Save new alarm",
                              style: TextStyle(
                                  fontFamily: 'Futura',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 16
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(32, 42, 24, 24),
                    child: Row(
                      children: [
                        Text(
                          "Add alarm",
                          style: TextStyle(
                              color: Palette.tymDark,
                              fontSize: 32,
                              fontFamily: 'Futura',
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: FaIcon(FontAwesomeIcons.close,size: 30,),
                        ),
                      ],
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatedTime(DateTime selectedTime) {
    DateTime tempDate = DateFormat.Hms().parse(selectedTime.hour.toString() +
        ":" +
        selectedTime.minute.toString() +
        ":" +
        '0' +
        ":" +
        '0');
    var dateFormat = DateFormat("h:mm a");
    return (dateFormat.format(tempDate));
  }

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }

  int idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.remainder(100000);
  }
}
