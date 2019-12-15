import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:async';

void goToMainPage(context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => TitleList()),
  );
}

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () => goToMainPage(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                    child: CircleAvatar(
                      radius: 100.0,
                      backgroundColor: Colors.black87,
                      child: CircleAvatar(
                          radius: 90.0,
                          backgroundColor: Colors.lightBlue[100].withOpacity(0.5),
                          child: Icon(
                            Icons.account_balance,
                            size: 100.0,
                            color: Colors.white,
                          )),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Center(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "U.S. CODE",
                            style: TextStyle(
                                fontSize: 40.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Titles 1 - 54",
                            style: TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    strokeWidth: 5.0,
                    valueColor:
                    new AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                ),
              ],
            ),
          ),
        );
  }
}