import 'package:flutter_socket_io/socket_io_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:societyappresidents/provider/ApiProvider.dart';
import 'dart:convert';

class Discussion extends StatefulWidget {
  @override
  _DiscussionState createState() => _DiscussionState();
}

class _DiscussionState extends State<Discussion> {
  SocketIOManager manager;
  SocketIO socketIO;
  SharedPreferences sharedPreferences;
  List messages;
  TextEditingController msgController = TextEditingController();
  final sendButton = FocusNode();
  final textField = FocusNode();
  var isLoading = true;

  @override
  void initState() {
    // TODO: implement initState

    messages = [];

    socketIO = SocketIOManager().createSocketIO(
      'https://murmuring-fortress-64796.herokuapp.com/',
      '/',
    );
    socketIO.init();
    socketIO.subscribe('news', (jsonData) {
      Map<String, dynamic> data = json.decode(jsonData);
      setState(() {
        print(data);
        messages.add({
          'user_name': data['name'],
          'message': data['message'],
          'user_id': data['user_id']
        });
      });
    });
    socketIO.connect();

    getMessages();
    super.initState();
  }

  getMessages() async {
    sharedPreferences = await SharedPreferences.getInstance();
    ApiProvider apiProvider = ApiProvider();
    messages = await apiProvider.getMessages();
    print(messages);

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Discussions",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.88,
        decoration: BoxDecoration(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: isLoading == true
                  ? Center(
                      child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ))
                  : messages == null
                      ? Center(
                          child: Text('No Conversation Yet !',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)))
                      : ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: sharedPreferences.getString('name') ==
                                      messages[index]['user_name']
                                  ? Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 10.0),
                                              child: Chip(
                                                avatar: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.grey.shade800,
                                                  child: Text(
                                                    messages[index]['user_name']
                                                            .split(' ')[0][0] +
                                                        messages[index]
                                                                ['user_name']
                                                            .split(' ')[1][0],
                                                    style: TextStyle(
                                                        fontSize: 13.0),
                                                  ),
                                                ),
                                                label: Text(messages[index]
                                                        ['user_name']
                                                    .toString()),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              margin:
                                                  EdgeInsets.only(right: 10.0),
                                              child: Text(
                                                messages[index]['message'],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  : Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin:
                                                  EdgeInsets.only(left: 10.0),
                                              child: Chip(
                                                avatar: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.grey.shade800,
                                                  child: Text(
                                                    messages[index]['user_name']
                                                            .split(' ')[0][0] +
                                                        messages[index]
                                                                ['user_name']
                                                            .split(' ')[1][0],
                                                    style: TextStyle(
                                                        fontSize: 13.0),
                                                  ),
                                                ),
                                                label: Text(messages[index]
                                                        ['user_name']
                                                    .toString()),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              margin: EdgeInsets.only(
                                                  left: 10.0, right: 10.0),
                                              child: Text(
                                                messages[index]['message'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                            );
                          },
                          shrinkWrap: true,
                        ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        focusNode: textField,
                        controller: msgController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              focusNode: sendButton,
                              onPressed: () {
                                socketIO.sendMessage(
                                    'message',
                                    json.encode({
                                      'message': msgController.text,
                                      'name':
                                          sharedPreferences.getString('name'),
                                      'user_id':
                                          sharedPreferences.getString('id')
                                    }));
                                setState(() {
                                  FocusScope.of(context)
                                      .requestFocus(sendButton);
                                  msgController.clear();
                                });
                              },
                              icon: Icon(Icons.send, color: Colors.black),
                            ),
                            hintText: "Type Here",
                            hintStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
