import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Notifications"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            itemBuilder: (ctx, index) => Card(
                  color: Colors.blue,
                  child: ListTile(
                    title: Text(
                      "messages",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )),
      ),
    );
  }
}
