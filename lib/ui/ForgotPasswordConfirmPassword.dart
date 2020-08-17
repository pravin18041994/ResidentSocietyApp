import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:societyappresidents/bloc/ChangePasswordBloc.dart';
import 'package:societyappresidents/ui/Login.dart';

class ForgotPasswordConfirmPassword extends StatefulWidget {
  @override
  _ForgotPasswordConfirmPasswordState createState() =>
      _ForgotPasswordConfirmPasswordState();
}

class _ForgotPasswordConfirmPasswordState
    extends State<ForgotPasswordConfirmPassword> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                      labelText: ' Set Password',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      border: UnderlineInputBorder())),
              TextFormField(
                  obscureText: true,
                  controller: confirmPassword,
                  onChanged: changePasswordBloc.getPassword,
                  decoration: InputDecoration(
                      labelText: ' Confirm Password',
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
                  if (password.text == confirmPassword.text) {
                    changePasswordBloc.dialogLoader(context);

                    resp =
                        await changePasswordBloc.changePasswordConfirmation();
                    if (resp == 'success') {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return Login();
                      }));
                    } else {
                      _scaffoldKey.currentState.showSnackBar(new SnackBar(
                          content: new Text("Please try again later !")));
                    }
                  } else {
                    _scaffoldKey.currentState.showSnackBar(new SnackBar(
                        content: new Text("Passwords Doesn't Match !")));
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
