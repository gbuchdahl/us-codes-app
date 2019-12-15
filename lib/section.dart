import 'package:flutter/material.dart';
import 'main.dart';
import 'data.dart';
import 'search.dart';
import 'title.dart';

class ParagraphList extends StatelessWidget {
  int titleIndex;
  int chapterIndex;
  int sectionIndex;
  ParagraphList(this.titleIndex, this.chapterIndex, this.sectionIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 4.0,
        title: Text(
          "${titleIndex + 1} U.S.C. §${sectionIndex + 1}",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.grey[100], // Color.fromRGBO(242, 242, 247, 1),
        child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Container(
                color: Colors.black,
                height: 1.0,
              ),
              Container(
                color: Colors.lightBlue[100].withOpacity(0.5),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: ListTile(
                    onTap: () {}, // clicking searched for item
                    onLongPress: () {}, // bring up information page for item
                    leading: Container(
                      height: 50.0,
                      width: 50.0,
                      color: Colors.black,
                      child: Center(
                        child: Container(
                          height: 47.0,
                          width: 47.0,
                          color: Colors.grey[200],
                          child: Center(
                            child: Text(
                              "§${sectionIndex + 1}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: RichText(
                      text: TextSpan(
                        text: sectionList[titleIndex][chapterIndex][
                            sectionIndex], //paragraphList[titleIndex][chapterIndex][sectionIndex][0],
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.black,
                height: 1.0,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  paragraphList[titleIndex][chapterIndex][sectionIndex][0],
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
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
