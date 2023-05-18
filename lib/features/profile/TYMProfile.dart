import 'package:animate_gradient/animate_gradient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../shared/TYMColors.dart';

class TYMProfile extends StatefulWidget {
  const TYMProfile({Key? key}) : super(key: key);

  @override
  State<TYMProfile> createState() => _TYMProfileState();
}
final tymUser = FirebaseAuth.instance.currentUser!;
class _TYMProfileState extends State<TYMProfile> {
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
        child: Container(
          height: double.infinity,
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 30,),
                        Text(
                          "Profile",
                          style: TextStyle(
                              color: Palette.tymDark,
                              fontSize: 36,
                              fontFamily: 'Futura',
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: OutlinedButton(onPressed: (){},
                            child: Text(
                              "Upgrade to Premium",
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
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 50,),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 46,
                                  width: 46,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Palette.kToDark.shade800
                                  ),
                                  child: FaIcon(FontAwesomeIcons.creditCard,color: Colors.white70,),
                                  alignment: Alignment.center,
                                ),
                                SizedBox(width: 20,),
                                Text(
                                  "Billing/Payment",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                Spacer(),
                                FaIcon(FontAwesomeIcons.chevronRight,size: 16,)

                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 46,
                                  width: 46,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Palette.kToDark.shade800
                                  ),
                                  child: FaIcon(FontAwesomeIcons.question,color: Colors.white70,),
                                  alignment: Alignment.center,
                                ),
                                SizedBox(width: 20,),
                                Text(
                                  "FAQs",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                Spacer(),
                                FaIcon(FontAwesomeIcons.chevronRight,size: 16,)

                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 46,
                                  width: 46,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Palette.kToDark.shade800
                                  ),
                                  child: FaIcon(FontAwesomeIcons.peopleGroup,color: Colors.white70,),
                                  alignment: Alignment.center,
                                ),
                                SizedBox(width: 20,),
                                Text(
                                  "Invite Friends",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                Spacer(),
                                FaIcon(FontAwesomeIcons.chevronRight,size: 16,)

                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 46,
                                  width: 46,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Palette.kToDark.shade800
                                  ),
                                  child: FaIcon(FontAwesomeIcons.headset,color: Colors.white70,),
                                  alignment: Alignment.center,
                                ),
                                SizedBox(width: 20,),
                                Text(
                                  "Help & Support",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                Spacer(),
                                FaIcon(FontAwesomeIcons.chevronRight,size: 16,)

                              ],
                            ),
                            SizedBox(height: 20,),
                            GestureDetector(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 46,
                                    width: 46,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Palette.kToDark.shade800
                                    ),
                                    child: FaIcon(FontAwesomeIcons.signOut,color: Colors.white70,),
                                    alignment: Alignment.center,
                                  ),
                                  SizedBox(width: 20,),
                                  Text(
                                    "Logout",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  Spacer(),
                                  FaIcon(FontAwesomeIcons.chevronRight,size: 16,)

                                ],
                              ),
                              onTap: () async{
                                await FirebaseAuth.instance.signOut();
                              },
                            ),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
