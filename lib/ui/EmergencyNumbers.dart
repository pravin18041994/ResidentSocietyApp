import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyNumbers extends StatefulWidget {
  @override
  _EmergencyNumbersState createState() => _EmergencyNumbersState();
}

class _EmergencyNumbersState extends State<EmergencyNumbers> {
  callPerson(var contact) async {
    var url = 'tel:+91 ' + contact;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  locationPerson() async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=16.837908,74.5947012';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<Null> getRefresh() async {
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0.0,
        title: Text("Emergency Numbers"),
      ),
      body: RefreshIndicator(
        onRefresh: getRefresh,
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (ctx, index) => Card(
                color: Colors.blue,
                child: ListTile(
                  title: Text(
                    "Ambulance ( Kothrud )",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "100",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: IconButton(
                    onPressed: () {
                      callPerson('100');
                    },
                    icon: Icon(
                      Icons.phone,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      locationPerson();
                    },
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
