import 'main.dart';
import 'data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<Post> fetchPost(int page) async {

  final response = await http.get('https://swapi.co/api/starships/${page}/');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

Future<List<Post>> getAllItems() async {
  var post = Post();
  List<String> itemsIds = ['1', '2', '3']; //different ids

  List<http.Response> list = await Future.wait(itemsIds.map((itemId) => http.get('https://swapi.co/api/starships/${itemId}/')));

  return list.map((response){
    // do processing here and return items
    return new Post();
  }).toList();
}

class Post {
  final String name;
  final String model;
  final String manufacturer;
  final String crew;

  Post({this.name, this.model, this.manufacturer, this.crew});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      name: json['name'],
      model: json['model'],
        manufacturer: json['manufacturer'],
        crew: json['crew'],
    );
  }
}

class APITest extends StatefulWidget {
  APITest({Key key}) : super(key: key);

  @override
  APITestState createState() => APITestState();
}

class APITestState extends State<APITest> {
  Future<Post> post;

  @override
  void initState() {
    super.initState();
    post = fetchPost(2);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Post>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(snapshot.data.name),
                      Text(snapshot.data.model),
                      Text(snapshot.data.manufacturer),
                      Text(snapshot.data.crew)
                    ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}