// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
class LeaderBoard extends StatefulWidget {
  static String routeName = "/leaderboard";
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  StreamController _postsController;

  loadPosts() async {
    buildleaderboard().then((res) async {
      _postsController.add(res);
      return res;
    });
  }
  int i = 0;
  Color my = Colors.brown, CheckMyColor = Colors.white;

   @override
  void initState() {
    _postsController = new StreamController();
    loadPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var r = TextStyle(color: Colors.purpleAccent, fontSize: 34);
    return Stack(
      children: <Widget>[
        Scaffold(
            body: Container(
          margin: EdgeInsets.only(top: 65.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 15.0, top: 10.0),
                child: RichText(
                    text: TextSpan(
                        text: "Leader",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                        children: [
                      TextSpan(
                          text: " Board",
                          style: TextStyle(
                              color: Colors.pink,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold))
                    ])),
              ),

              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Global Rank Board: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                  child: StreamBuilder(
                      stream: _postsController.stream,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          i = 0;
                          return ListView.builder(
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, index) {
                                print(index);
                                if (index >= 1) {
                                  print('Greater than 1');
                                  if (snapshot.data.documents[index]
                                          .data['MyPoints'] ==
                                      snapshot.data.documents[index - 1]
                                          .data['MyPoints']) {
                                    print('Same');
                                  } else {
                                    i++;
                                  }
                                }

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0, vertical: 5.0),
                                  child: InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: i == 0
                                                  ? Colors.amber
                                                  : i == 1
                                                      ? Colors.grey
                                                      : i == 2
                                                          ? Colors.brown
                                                          : Colors.white,
                                              width: 3.0,
                                              style: BorderStyle.solid),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0, left: 15.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    CircleAvatar(
                                                        child: Container(
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                image: DecorationImage(
                                                                    image: NetworkImage(snapshot
                                                                            .data
                                                                            .documents[
                                                                                index]
                                                                            .data[
                                                                        'photoUrl']),
                                                                    fit: BoxFit
                                                                        .fill)))),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0, top: 10.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          snapshot
                                                              .data
                                                              .documents[index]
                                                              .data['Name'],
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .deepPurple,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          maxLines: 6,
                                                        )),
                                                    Text("Points: " +
                                                        snapshot
                                                            .data
                                                            .documents[index]
                                                            .data['MyPoints']
                                                            .toString()),
                                                  ],
                                                ),
                                              ),
                                              Flexible(child: Container()),
                                        
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 20.0,
                                                    top: 13.0,
                                                    right: 20.0),
                              
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }))
            ],
          ),
        )),
      ],
    );
  }
}


Future buildleaderboard() async {
  final response = await http.get(
    Uri.parse('http://192.168.61.217:8000/leaderboard'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);

  }
  else {
    throw Exception('Failed to load post');
  }
}