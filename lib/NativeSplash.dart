import 'package:dsc3_last_task/main.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class NativeSplash extends StatefulWidget {
  @override
  _NativeSplashState createState() => _NativeSplashState();
}

class _NativeSplashState extends State<NativeSplash> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Replace the 3 second delay with your initialization code:
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(color: Color(0xFFf0eccc)),
                ),
              ));
        } else {
          // Loading is done, return the app:
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: SplashScreen(
                title: Text(
                  "Date & Time",
                  style: TextStyle(
                      color: Color(0xFFf0ebcc),
                      fontSize: 35,
                      fontWeight: FontWeight.w500),
                ),
                backgroundColor: Color(0xFF34656d),
                seconds: 4,
                image: Image.asset("asset/images/calendar.png",
                    color: Color(0xFFf0ebcc)),
                photoSize: 50,
                navigateAfterSeconds: MainApp(),
                loaderColor: Color(0xFFededd0),
              ),
            ),
          );
        }
      },
    );
  }
}
