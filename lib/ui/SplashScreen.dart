import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:societyappresidents/ui/Login.dart';
import 'package:societyappresidents/ui/MainPage.dart';

import 'WalkthroughPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var screenName;
  var token;
  var storage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        getToken();
      });
    });
  }

  getToken() async {
    storage = FlutterSecureStorage();
    token = await storage.read(key: "token");
    if (token == null) {
      print('inhere');
      screenName = Login();
    } else {
      print('two');
      screenName = MainPage();
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screenName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[400],
        body: Center(
          child: SizedBox(
            width: 250.0,
            child: TypewriterAnimatedTextKit(
                isRepeatingAnimation: false,
                speed: Duration(milliseconds: 425),
                text: [
                  "Smart Society",
                ],
                textStyle: TextStyle(
                    fontSize: 30.0, fontFamily: "Raleway", color: Colors.white),
                textAlign: TextAlign.center,
                alignment: AlignmentDirectional.topStart // or Alignment.topLeft
                ),
          ),
        ));
  }
}
