import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:societyappresidents/bloc/ChangePasswordBloc.dart';

import 'ForgotPasswordOtp.dart';

class ForgotPasswordMobileNumber extends StatefulWidget {
  @override
  _ForgotPasswordMobileNumberState createState() =>
      _ForgotPasswordMobileNumberState();
}

class _ForgotPasswordMobileNumberState
    extends State<ForgotPasswordMobileNumber> {
  var resp;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.blue[400],
      body: AlertDialog(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(color: Colors.black, width: 2.0)),
        backgroundColor: Colors.white,
        content: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextFormField(
                  style: TextStyle(color: Colors.blue),
                  keyboardType: TextInputType.phone,
                  onChanged: changePasswordBloc.getContact,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10)
                  ],
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      labelText: ' Mobile Number',
                      labelStyle: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      border: UnderlineInputBorder())),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                onPressed: () async {
                  changePasswordBloc.dialogLoader(context);
                  resp = await changePasswordBloc.changePasswordGetContact();

                  if (resp == "success") {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return ForgotPasswordOtp();
                    }));
                  } else {
                    Navigator.pop(context);
                    _scaffoldKey.currentState.showSnackBar(new SnackBar(
                        content: new Text("Mobile Number Not Registered !",
                            style: TextStyle(fontFamily: 'Ralweway'))));
                  }
                },
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Colors.black, width: 2.0)),
                child: Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
