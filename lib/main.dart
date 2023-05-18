import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:tuneyourmindtym/TYMNotificationsHelper.dart';
import 'package:tuneyourmindtym/auth/TYMLoginScreen.dart';
import 'package:tuneyourmindtym/firebase_options.dart';
import 'package:tuneyourmindtym/shared/TYMColors.dart';
import 'package:flutter/services.dart';
import 'auth/TYMLoginScreen.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final _notificationsInit = FlutterLocalNotificationsPlugin();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Future.wait([
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
  JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  ),
  TYMNotificationsHelper.initialize(initScheduled:true)
  ]);
  listenNotifications();
  runApp(const MyApp());
}

void listenNotifications() {
  TYMNotificationsHelper.onNotifications.stream.listen((event) {

  });
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TYMLoginScreen(),
      theme: ThemeData(
          primarySwatch: Palette.kToDark,
          inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8)
              )
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  backgroundColor: Palette.kToDark.shade800,
                  primary: Colors.white
              )
          ),
          scaffoldBackgroundColor: Palette.tymLight
      ),
    );
  }


}

