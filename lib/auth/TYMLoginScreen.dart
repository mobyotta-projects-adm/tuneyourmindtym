import 'package:animate_gradient/animate_gradient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:tuneyourmindtym/dashboard/dashboard.dart';

import '../shared/TYMColors.dart';

class TYMLoginScreen extends StatefulWidget {
  const TYMLoginScreen({Key? key}) : super(key: key);
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TYMLoginScreen> createState() => _TYMLoginScreenState();
}

class _TYMLoginScreenState extends State<TYMLoginScreen> with SingleTickerProviderStateMixin{
late AnimationController controller;

@override
  void initState() {
  controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:AnimateGradient(
        primaryBegin: Alignment.centerLeft,
        primaryEnd: Alignment.centerRight,
        secondaryBegin: Alignment.centerLeft,
        secondaryEnd: Alignment.centerRight,
        primaryColors: [
          Palette.tymDark.withOpacity(0.7),
          Palette.kToDark.shade100,
          Palette.tymLight
        ],
        secondaryColors: [
          Palette.tymLight,
          Palette.kToDark.shade100,
          Palette.tymDark.withOpacity(0.7)
        ],
        duration: Duration(seconds: 4),
        animateAlignments: true,
        child: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return TYMDashboard();
              }
              return SignInScreen(
                providerConfigs: [
                  EmailProviderConfiguration(),
                  GoogleProviderConfiguration(clientId: ''),
                  AppleProviderConfiguration()
                ],
                headerBuilder: (context,constraints,_){
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: AspectRatio(
                      aspectRatio: 1  ,
                      child: Image.asset("assets/tymlogo.png",height: 250,),
                    ),
                  );
                },
                subtitleBuilder: (context,action){
                  return Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Text(
                      action == AuthAction.signIn ? "Welcome back! Login to continue" : "Create an account to continue"
                    ),
                  );
                },
              );
            }

          ),
      ),
    );
  }

  @override
  dispose() {
  controller.dispose();
    super.dispose();
  }
}
