import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:societyappresidents/bloc/ProfileBloc.dart';
import 'package:societyappresidents/bloc/ResidentBloc.dart';
import 'package:societyappresidents/models/FlatsModel.dart';
import 'package:societyappresidents/provider/ApiProvider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var dropdownValueSocietyUpdateController;
  var dropdownValueFlatUpdate;
  List<String> flats;
  var dropdownValueTypeUpdate;
  var resp;
  List profileData;
  var id;
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController memberNameController = TextEditingController();
  FlatsModel flatsModel;
  List societies;
  List<String> societyNames;
  var dropdownValueRelation;
  List profileData2;
  var societyType;
  var userId;

  @override
  void initState() {
    // TODO: implement initState

    getSocities();
    super.initState();
    societyNames = [];
    societies = [];
    profileData = [];
    profileData2 = [];
    flats = [];
    Future.delayed(Duration(seconds: 5));
    getProfileData();
    Future.delayed(Duration(seconds: 5));
  }

  // getFlats() async {
  //   for (var i in societies) {
  //     print(dropdownValueSocietyUpdateController+"hjgbjhgj");
  //     if (i['_id'] == dropdownValueSocietyUpdateController) {
  //       print("inhere");
  //       id = i['_id'];
  //       flatsModel = await profilBloc.getFlats(id);
  //       print(flatsModel.data.runtimeType);
  //       for (var i in flatsModel.data) {
  //         setState(() {
  //           flats.add(i);
  //           dropdownValueFlatUpdate =
  //         });

  //       }
  //     }
  //   }
  // }

  getSocities() async {
    ApiProvider apiProvider = ApiProvider();
    societies = await apiProvider.getSocieties();
    if (mounted) {
      setState(() {
        print(societies);
        for (var i in societies) {
          print(i['name']);
          societyNames.add(json.encode({'name': i['name'], 'id': i['_id']}));
        }
      });
    }
  }

  getProfileData() async {
    ApiProvider apiProvider = ApiProvider();
    profileData = await apiProvider.getProfileDetails();
    print(profileData.length);
    for (var i in profileData) {
      if (mounted) {
        setState(() {
          for (var jj in i['society']['flats']) {
            flats.add(jj);
          }
          ownerNameController.text = i['owner_name'];
          emailController.text = i['email'];
          mobileNumberController.text = i['contact'];
          dropdownValueSocietyUpdateController = i['society']['_id'];
          dropdownValueFlatUpdate = i['flat_no'];
          societyType = i['type'];
          userId = i['_id'];
          for (var j in i['members']) {
            profileData2.add({'name': j['name'], 'relation': j['relation']});
          }
        });
      }
    }
  }

  void dialogBoxFamilyDetails() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: BorderSide(color: Colors.white)),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ListTile(
                          title: TextFormField(
                            style: TextStyle(color: Colors.black),
                            controller: memberNameController,
                            decoration: InputDecoration(
                                labelText: "Full Name",
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                        ),
                        ListTile(
                          title: DropdownButton<String>(
                            value: dropdownValueRelation,
                            iconSize: 0.0,
                            elevation: 16,
                            hint: Text(
                              "Relation",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15.0),
                            ),
                            underline: Container(
                              height: 1,
                              color: Colors.black,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                print(newValue);
                                dropdownValueRelation = newValue;
                              });
                            },
                            items: <String>[
                              "Father",
                              "Mother",
                              "Son",
                              "Daughter",
                              "Wife",
                              "Friends",
                              "Others"
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () {
                                setState(() {
                                  profileData2.add({
                                    'name': memberNameController.text,
                                    'relation': dropdownValueRelation.toString()
                                  });
                                  Navigator.pop(context);
                                });
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.white)),
                              color: Colors.white,
                              elevation: 5.0,
                              child: Text(
                                "Add",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.white)),
                              color: Colors.white,
                              elevation: 5.0,
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          title: new Text(
            "Add Family Details",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
      },
    ).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.blue[400],
        appBar: AppBar(
          backgroundColor: Colors.blue[400],
          leading: Icon(
            Icons.arrow_back,
            size: 0.0,
          ),
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "Profile",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: dropdownValueSocietyUpdateController == null
            ? Center(
                child: CircularProgressIndicator(
                    backgroundColor: Colors.cyanAccent),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.85,
                    width: MediaQuery.of(context).size.width * 0.90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage("images/img1.jpg"),
                                    maxRadius: 60,
                                  ),
                                  ListTile(
                                    title: IgnorePointer(
                                      ignoring: true,
                                      child: DropdownButton<String>(
                                        value:
                                            dropdownValueSocietyUpdateController,
                                        iconSize: 0.0,
                                        elevation: 16,
                                        hint: Text(
                                          "Society/Apartment",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0),
                                        ),
                                        underline: Container(
                                          height: 1,
                                          color: Colors.white,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            dropdownValueSocietyUpdateController =
                                                newValue;
                                          });
                                        },
                                        items: societyNames
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: json
                                                .decode(value)['id']
                                                .toString(),
                                            child: Text(
                                              json
                                                  .decode(value)['name']
                                                  .toString(),
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    title: TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      controller: ownerNameController,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please Enter Owner Name !';
                                        }

                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          focusColor: Colors.white,
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          labelText: "Owner Name",
                                          labelStyle: TextStyle(
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                  ListTile(
                                    title: IgnorePointer(
                                      ignoring: true,
                                      child: DropdownButton<String>(
                                        value: dropdownValueFlatUpdate,
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.white,
                                        ),
                                        iconSize: 0.0,
                                        elevation: 16,
                                        hint: Text(
                                          "Flat Number",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0),
                                        ),
                                        underline: Container(
                                          height: 1,
                                          color: Colors.white,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            dropdownValueFlatUpdate = newValue;
                                          });
                                        },
                                        items: flats
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    title: TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please Enter Contact Number !';
                                        }

                                        return null;
                                      },
                                      controller: mobileNumberController,
                                      decoration: InputDecoration(
                                          labelText: "Mobile Number",
                                          labelStyle: TextStyle(
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                  ListTile(
                                    title: TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please Enter Email !';
                                        }

                                        return null;
                                      },
                                      controller: emailController,
                                      decoration: InputDecoration(
                                          labelText: "Email",
                                          labelStyle: TextStyle(
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                  ListTile(
                                    trailing: IconButton(
                                      onPressed: () {
                                        dialogBoxFamilyDetails();
                                      },
                                      tooltip: "Update Family Details",
                                      icon: Icon(
                                        Icons.update,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: Text(
                                      "Family Details",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.white,
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    margin: EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: profileData2.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            title: Text(
                                              profileData2[index]['name']
                                                      .toString() +
                                                  "(" +
                                                  profileData2[index]
                                                          ['relation']
                                                      .toString() +
                                                  ")",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: RaisedButton(
                            color: Colors.white,
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                profilBloc.dialogLoader(context);
                                profilBloc.ownerName.value =
                                    ownerNameController.text;
                                profilBloc.email.value = emailController.text;
                                profilBloc.mobileNumber.value =
                                    mobileNumberController.text;
                                profilBloc.familyDetailString.value =
                                    json.encode(profileData2).toString();
                                profilBloc.flatNumber.value =
                                    dropdownValueFlatUpdate.toString();
                                profilBloc.society.value =
                                    dropdownValueSocietyUpdateController
                                        .toString();
                                profilBloc.societyType.value =
                                    societyType.toString();
                                resp = await profilBloc.updateResidentDetails();
                                if (resp == "success") {
                                  Navigator.pop(context);
                                  _scaffoldKey.currentState.showSnackBar(
                                      new SnackBar(
                                          content: new Text(
                                              "Updated Successfully !",
                                              style: TextStyle(
                                                  fontFamily: 'Raleway'))));
                                } else {
                                  Navigator.pop(context);
                                  _scaffoldKey.currentState.showSnackBar(
                                      new SnackBar(
                                          content: new Text(
                                              "Please try again later !",
                                              style: TextStyle(
                                                  fontFamily: 'Raleway'))));
                                }
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                    color: Colors.white, width: 2.0)),
                            child: Text(
                              "Update",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
