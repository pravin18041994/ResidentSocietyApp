import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:societyappresidents/bloc/VisitorBloc.dart';

class VisitorHistory extends StatefulWidget {
  @override
  _VisitorHistoryState createState() => _VisitorHistoryState();
}

class _VisitorHistoryState extends State<VisitorHistory> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController noOfPersonController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final FocusNode nodeName = FocusNode();
  final FocusNode nodeMobileNumber = FocusNode();
  final FocusNode nodeNoOfPerson = FocusNode();
  final FocusNode nodeSubmitButton = FocusNode();
  final _formKey = GlobalKey<FormState>();

  List visitorList;
  var isLoading = false;
  var resp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    visitorList = [];
    getVisitors();
  }

  Future<Null> getRefresh() async {
    await Future.delayed(Duration(seconds: 2));
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  getVisitors() async {
    List temp = [];
    temp = await visitorBloc.getVisitorDetails();
    setState(() {
      isLoading = true;
      visitorList = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text("Visitor History"),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.directions_car),
                text: " Visitor Form",
              ),
              Tab(
                icon: Icon(Icons.directions_transit),
                text: "Visitor History",
              )
            ],
          ),
        ),
        body: TabBarView(children: [
          //visitor form
          Form(
            key: _formKey,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.77,
                    child: Card(
                      color: Colors.blue,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ListTile(
                            title: TextFormField(
                              focusNode: nodeName,
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              onChanged: visitorBloc.getVisitorName,
                              controller: nameController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please Enter  Name !';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  focusColor: Colors.white,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  labelText: "Name",
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                          ListTile(
                            title: TextFormField(
                              focusNode: nodeMobileNumber,
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              onChanged: visitorBloc.getVisitorNumber,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10)
                              ],
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please Enter Contact Number !';
                                }
                                return null;
                              },
                              controller: mobileController,
                              decoration: InputDecoration(
                                  labelText: "Mobile Number",
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                          ListTile(
                            title: TextFormField(
                              focusNode: nodeNoOfPerson,
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              onChanged: visitorBloc.getNumberOfPersons,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(2)
                              ],
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please number of persons !';
                                }
                                return null;
                              },
                              controller: noOfPersonController,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  labelText: "Total number of person",
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: RaisedButton(
                              focusNode: nodeSubmitButton,
                              color: Colors.white,
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  dialogLoader(context);
                                  resp = await visitorBloc.visitorDetails();
                                  if (resp == 'success') {
                                    FocusScope.of(context)
                                        .requestFocus(nodeSubmitButton);
                                    Navigator.pop(context);
                                    _scaffoldKey.currentState.showSnackBar(
                                        new SnackBar(
                                            content: new Text(
                                                "Added Successfully !",
                                                style: TextStyle(
                                                    fontFamily: 'Raleway'))));
                                    mobileController.clear();
                                    nameController.clear();
                                    noOfPersonController.clear();
                                  } else {
                                    FocusScope.of(context)
                                        .requestFocus(nodeSubmitButton);
                                    Navigator.pop(context);
                                    _scaffoldKey.currentState.showSnackBar(
                                        new SnackBar(
                                            content: new Text(
                                                "Cannot add now !",
                                                style: TextStyle(
                                                    fontFamily: 'Raleway'))));
                                    mobileController.clear();
                                    nameController.clear();
                                    noOfPersonController.clear();
                                  }
                                }
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(
                                      color: Colors.black, width: 2.0)),
                              child: Text(
                                "Add",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //visitor history
          RefreshIndicator(
            onRefresh: getRefresh,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: isLoading == false
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blue,
                      ),
                    )
                  : visitorList.length == 0
                      ? Center(
                          child: Text("No data"),
                        )
                      : ListView.builder(
                          itemCount: visitorList.length,
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) => Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              margin: EdgeInsets.all(5),
                              child: Card(
                                color: Colors.blue,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Name :",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                        Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              visitorList[index]['name'] == null
                                                  ? "-"
                                                  : visitorList[index]['name'],
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Total persons:",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                        Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              visitorList[index]
                                                  ['no_of_persons'],
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Date :",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                        Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              visitorList[index]['date'],
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Time :",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                        Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              visitorList[index]['time'],
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ))),
            ),
          ),
        ]),
      ),
    );
  }
}
