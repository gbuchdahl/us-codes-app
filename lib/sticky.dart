import 'main.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'screensize.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'section.dart';
import 'chapter.dart';


class MasterStickyList extends StatefulWidget {

  int titleIndex;
  int chapterIndex;
  MasterStickyList(this.titleIndex, this.chapterIndex);

  @override
  MasterStickyListState createState() => MasterStickyListState(titleIndex, chapterIndex);
}

class MasterStickyListState extends State<MasterStickyList> {

  int titleIndex;
  int chapterIndex;
  MasterStickyListState(this.titleIndex, this.chapterIndex);

  final ScrollController controller = ScrollController();

  @override
  void initState() {
    controller.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "${titleIndex + 1} U.S. Code Title ${titleIndex + 1}",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemBuilder: (context, chapIndex) => StickyHeader(
            header: Container(
              color: Colors.lightBlue[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: Colors.black,
                    height: 1.0,
                  ),
                  Container(
                    color: Colors.grey[300],
                    height: 1.0,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                    child: ListTile(
                      onTap: () { // maybe change this to show a dropdown instead?
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SectionList(titleIndex, chapIndex)));
                      },
                      // clicking searched for item
                      onLongPress: () {},
                      // bring up information page for item
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
                                "${ToRoman(chapIndex + 1)}",
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
                          text: chapterList[chapterIndex][chapIndex],
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(chapterSectionList[chapterIndex][chapIndex]),
                      ),
//                  trailing: Icon(Icons.arrow_right),
                    ),
                  ),
                  Container(
                    color: Colors.black,
                    height: 1.0,
                  ),
                ],
              ),
            ),
            content: ListView.separated(
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              padding: EdgeInsets.fromLTRB(0.0, 9.0, 0.0, 9.0),
              itemBuilder: (context, index) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        child: ListTile(
                          onTap: () { Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ParagraphList(titleIndex, chapIndex, index))); },         // clicking searched for item
                          onLongPress: () { },   // bring up information page for item
                          leading: Container(
                            height: 40.0,
                            width: 40.0,
                            color: Colors.black,
                            child: Center(
                              child: Container(
                                height: 37.0,
                                width: 37.0,
                                color: Colors.grey[200],
                                child: Center(
                                  child: Text(
                                    "§${index + 1}",
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
                              text: sectionList[titleIndex][chapIndex][index],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
//                GestureDetector(
//                onTap: () => {
//                },
//                child: Container(
//                  color: Colors.transparent,
//                  child: Padding(
//                    padding: EdgeInsets.fromLTRB(20.0, 4.0, 0.0, 4.0),
//                    child: RichText(
//                      text: TextSpan(
//                        style:
//                        TextStyle(fontSize: 17.0, color: Colors.black),
//                        children: <TextSpan>[
//                          TextSpan(text: sectionList[titleIndex][chapIndex][index], style: TextStyle(fontWeight: FontWeight.normal)),
//                        ],
//                      ),
//                    ),
//                  ),
//                ),
//              );
              },
              itemCount: sectionList[titleIndex][chapIndex].length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
            ),
        ),
        shrinkWrap: true,
        itemCount: chapterList[chapterIndex].length,
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

class TestSticky extends StatelessWidget {

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
          "USC",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: MasterStickyList(0, 0),
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

  void showChapter(context, titleIndex, chapterIndex) {
    showBottomSheet(
      context: context,
      builder: (context) => Container(
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(6.0),
          border: new Border.all(
            width: 3.0,
            color: Colors.grey[300],
          ),
        ),
        height: screenHeightExcludingToolbar(context, dividedBy: 1.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  Text(
                    "${titleIndex + 1} U.S. Code Chapter ${chapterIndex + 1}",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                  IconButton(
                    icon: Icon(Icons.expand_more),
                    onPressed: () => {Navigator.pop(context)},
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              height: 1.0,
            ),
            Flexible(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                            child: ListTile(
                              onTap: () {},
                              // clicking searched for item
                              onLongPress: () {},
                              // bring up information page for item
                              leading: Container(
                                height: 50.0,
                                width: 50.0,
                                color: Colors.grey[200],
                                child: Center(
                                  child: Text(
                                    "§${index + 1}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 14.0),
                                  ),
                                ),
                              ),
                              title: RichText(
                                text: TextSpan(
                                  text: "Hi"
                                  [index],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 1.0,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                    itemCount: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}