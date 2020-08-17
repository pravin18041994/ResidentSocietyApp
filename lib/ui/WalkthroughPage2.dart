import 'package:flutter/material.dart';

import 'WalkthroughPage1.dart';
import 'WalkthroughPage3.dart';

class WalkthroughPage2 extends StatefulWidget {
  @override
  _WalkthroughPage2State createState() => _WalkthroughPage2State();
}

class _WalkthroughPage2State extends State<WalkthroughPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.7,
                child: Image.asset("images/img2.jpg"),
              ),
            ),
            Container(
              color: Colors.amber,
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Center(child: Text("Descriptions")),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return WalkthroughPage1();
                      }));
                    },
                    child: Text("Previous"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return WalkthroughPage3();
                      }));
                    },
                    child: Text("Next"),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
