import 'package:flutter/material.dart';
import 'data.dart';
import 'main.dart';

class DataSearch extends SearchDelegate<String> {

  List giveMaster(List sleights) {
    var descriptions = [];

    for (int i = 0; i < sleights.length; i++){
      for (int j = 0; j < titleList.length; j++) {
        if (titleList.where((p) => p.startsWith(query)).toList()[i] == titleList[j]){
          descriptions.add(description_list[j]);
        }
      }
    }
    return descriptions;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO!
    return null;
  }

  // implement searching for title number functionality
  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestion_list = query.isEmpty
        ? [titleList, description_list]
        : [titleList.where((p) => p.startsWith(query)).toList(), giveMaster(titleList.where((p) => p.startsWith(query)).toList())];

    return Container(
      color: Color.fromRGBO(242, 242, 247, 1),
      child: ListView.builder(
        itemBuilder: (context, index) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
              child: ListTile(
                onTap: () { }, // clicking searched for item
                onLongPress: () {}, // bring up information page for item
                leading: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 32.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    radius: 30.0,
                    child: Text(
                      ToRoman(index + 1),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14.0),
                    ),
                  ),
                ),
                title: RichText(
                  text: TextSpan(
                      text: suggestion_list[0][index].substring(0, query.length),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                      children: [
                        TextSpan(
                          text: suggestion_list[0][index].substring(query.length),
                          style: TextStyle(color: Colors.grey, fontSize: 20.0),
                        )
                      ]),
                ),
                subtitle: Text(suggestion_list[1][index]),
              ),
            ),
          ),
          Container(
            height: 1.0,
            color: Colors.grey[300],
          ),
          ],
        ),
        itemCount: suggestion_list[0].length,
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