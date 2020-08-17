import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:societyappresidents/bloc/ChangePasswordBloc.dart';

import 'ForgotPasswordConfirmPassword.dart';

class ForgotPasswordOtp extends StatefulWidget {
  @override
  _ForgotPasswordOtpState createState() => _ForgotPasswordOtpState();
}

class _ForgotPasswordOtpState extends State<ForgotPasswordOtp> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var resp;
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
                  keyboardType: TextInputType.number,
                  onChanged: changePasswordBloc.getOTP,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4)
                  ],
                  decoration: InputDecoration(
                      labelText: ' Otp',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      border: UnderlineInputBorder())),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                onPressed: () async {
                  changePasswordBloc.dialogLoader(context);
                  resp = await changePasswordBloc.changePasswordVerifyOTP();

                  if (resp == 'success') {
                    Navigator.pop(context);

                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return ForgotPasswordConfirmPassword();
                    }));
                  } else {
                    Navigator.pop(context);
                    _scaffoldKey.currentState.showSnackBar(new SnackBar(
                        content: new Text("Invalid Otp !",
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
                    color: Colors.black,
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
