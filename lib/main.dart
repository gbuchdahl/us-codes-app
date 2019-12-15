import 'package:flutter/material.dart';
import 'package:us_codes/sticky.dart';
import 'screensize.dart';
import 'data.dart';
import 'search.dart';
import 'API.dart';
import 'title.dart';
import 'splash.dart';
import 'package:flutter/services.dart';


void main() {runApp(new MyApp());}

class MyApp extends StatelessWidget {
  // This widget is the root of your applicaßtion.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new SplashScreen());
  }
}

class TitleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: new Drawer(
        elevation: 4.0,
        child: new ListView(
          children: <Widget>[
            DrawerHeader(
              child: Logo(),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300], width: 2.0),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "U.S. CODE",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  "Titles 1 - 54",
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            new Divider(
              thickness: 2.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: "U.S. Codes ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                "is an app developed by Gabe Buchdahl (Yale College '22) and Max Lukianchikov (Yale College '20) as part of their class "),
                        TextSpan(
                            text: "CPSC 183: Law, Technology, and Culture, ",
                            style: TextStyle(fontStyle: FontStyle.italic),),
                        TextSpan(
                            text:
                            "taught by Lecturer and Harvard Law graduate Brad Rosen."),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text("Settings go here!")
                  )
                ],
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.menu, color: Colors.black,),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        elevation: 4.0,
        title: Text(
          "U.S. Code",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: TitleDataSearch(titleList, titleDescriptionList));
            },
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: MainList(),
    );
  }
}

class MainList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100], // Color.fromRGBO(242, 242, 247, 1),
      child: ListView.builder(
        itemBuilder: (context, index) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                child: ListTile(
                  onTap: () {
                    index != 52 ? Navigator.push( context,MaterialPageRoute(builder: (context) => ChapterList(index))) : null;
                  }, // clicking searched for item
                  onLongPress: () {
                    print("Long");
                  }, // bring up information page for item
                  leading: Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 32.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        radius: 26.0,
                        child: Text(
                          ToRoman(index + 1),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 14.0),
                        ),
                      ),
                    ),
                  ),
                  title: RichText(
                    text: TextSpan(
                      text: titleList[index],
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                  subtitle: Text(titleDescriptionList[index]),
//                  trailing: Icon(Icons.arrow_right),
                ),
              ),
            ),
            Container(
              height: 1.0,
              color: Colors.grey[300],
            ),
          ],
        ),
        itemCount: titleList.length,
      ),
    );
  }

  String ToRoman(index) {
    if (index <= 0) {
      return "";
    }

    if (index >= 1000) return "M" + ToRoman(index - 1000);
    if (index >= 900) return "CM" + ToRoman(index - 900);
    if (index >= 500) return "D" + ToRoman(index - 500);
    if (index >= 400) return "CD" + ToRoman(index - 400);
    if (index >= 100) return "C" + ToRoman(index - 100);
    if (index >= 90) return "XC" + ToRoman(index - 90);
    if (index >= 50) return "L" + ToRoman(index - 50);
    if (index >= 40) return "XL" + ToRoman(index - 40);
    if (index >= 10) return "X" + ToRoman(index - 10);
    if (index >= 9) return "IX" + ToRoman(index - 9);
    if (index >= 5) return "V" + ToRoman(index - 5);
    if (index >= 4) return "IV" + ToRoman(index - 4);
    if (index >= 1) return "I" + ToRoman(index - 1);
  }
}

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 70.0,
      backgroundColor: Colors.black87,
      child: CircleAvatar(
        radius: 65.0,
        backgroundColor: Colors.lightBlue[100].withOpacity(0.5),
        child: Center(
          child: Icon(
            Icons.account_balance,
            size: 85.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
