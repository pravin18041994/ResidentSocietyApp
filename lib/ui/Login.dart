import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:societyappresidents/bloc/LoginBloc.dart';

import 'package:societyappresidents/ui/ForgotPasswordMobileNumber.dart';
import 'package:societyappresidents/ui/MainPage.dart';

import 'package:societyappresidents/ui/ResidentForm.dart';
import 'package:societyappresidents/ui/TenantForm.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var resp;
  Icon i;
  var passwordVisible;
  SharedPreferences sharedPreferences;
  var backResult;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    i = Icon(Icons.visibility_off);
    passwordVisible = true;
    getPrefs();
  }

  getPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void dialogBoxUserType() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: BorderSide(color: Colors.black)),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () async {
                        Navigator.pop(context);

                        backResult = await Navigator.push(context,
                            MaterialPageRoute(builder: (_) {
                          return ResidentForm();
                        }));
                        if (backResult == "from registration") {
                          //snackbar dikha
                          _scaffoldKey.currentState.showSnackBar(new SnackBar(
                              content: new Text("Registered Successfully !",
                                  style: TextStyle(fontFamily: 'Raleway'))));
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black)),
                      color: Colors.white,
                      elevation: 5.0,
                      child: Text(
                        "Resident",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black)),
                      color: Colors.white,
                      elevation: 5.0,
                      child: Text(
                        "Tenant",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return TenantForm();
                        }));

                        ;
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          title: new Text(
            "Select Type",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return null;
      },
      child: Form(
        key: _formKey,
        child: Scaffold(
          key: _scaffoldKey,
          body: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [Colors.blue[400], Colors.blue[400]])),
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          'Smart Society',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 35.0),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: TextFormField(
                              onChanged: loginBloc.getUserContact,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please Enter Contact Number !';
                                }
                                print(value.length);
                                if (value.length < 10) {
                                  return 'Please Enter Valid Contact Number !';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.phone,
                                    color: Colors.black,
                                  ),
                                  labelText: "Contact",
                                  labelStyle: TextStyle(color: Colors.black)),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: TextFormField(
                              onChanged: loginBloc.getUserPassword,
                              obscureText: true,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please Enter Password !';
                                }

                                return null;
                              },
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (i.toString() ==
                                            Icon(Icons.visibility_off)
                                                .toString()) {
                                          print("inhere");
                                          i = Icon(Icons.visibility);
                                        } else {
                                          i = Icon(Icons.visibility_off);
                                        }
                                        passwordVisible = !passwordVisible;
                                      });
                                    },
                                    icon: i,
                                  ),
                                  labelText: "Password",
                                  labelStyle: TextStyle(color: Colors.black)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            side: BorderSide(color: Colors.black)),
                        onPressed: () async {
                          
                          if (_formKey.currentState.validate()) {
                            loginBloc.dialogLoader(context);
                            resp = await loginBloc.login();
                            if (resp == "success") {
                              loginBloc.dispose();
                              Navigator.pop(context); 
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return MainPage();
                              }));
                            } else {
                              loginBloc.dispose();
                              Navigator.pop(context);
                              _scaffoldKey.currentState.showSnackBar(
                                  new SnackBar(
                                      content: new Text("Invalid Credentials !",
                                          style: TextStyle(
                                              fontFamily: 'Raleway'))));
                            }
                          }
                        },
                        child: Text(
                          "Login",
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            dialogBoxUserType();
                          },
                          child: Text(
                            "New User?",
                            style: TextStyle(),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return ForgotPasswordMobileNumber();
                            }));
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
