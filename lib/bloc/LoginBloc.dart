import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:societyappresidents/repositories/Repository.dart';

class LoginBloc {
  Repository repository = Repository();

  final userContactNumber = BehaviorSubject<String>();
  final userPassword = BehaviorSubject<String>();
  Function(String) get getUserContact => userContactNumber.sink.add;
  Function(String) get getUserPassword => userPassword.sink.add;

  Future<String> login() async {
    var resp;
    resp = await repository.login(userContactNumber.value, userPassword.value);
    return resp;
  }

  dialogLoader(context) {
    AlertDialog alert = AlertDialog(
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      content: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            backgroundColor: Colors.blueAccent,
          )
        ],
      )),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  dispose() {
    userPassword.close();
    userContactNumber.close();
  }
}

final loginBloc = LoginBloc();
