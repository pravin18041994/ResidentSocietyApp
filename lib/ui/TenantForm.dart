import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:societyappresidents/bloc/TenantBloc.dart';
import 'package:societyappresidents/provider/ApiProvider.dart';

class TenantForm extends StatefulWidget {
  @override
  _TenantFormState createState() => _TenantFormState();
}

class _TenantFormState extends State<TenantForm> {
  var dropdownValueFlat;
  var dropdownValueType;
  var dropdownValueRelation;
  var dropdownValueSocietyType;
  static const scale = 100.0 / 72.0;

  List partnerDetails;
  TextEditingController memberNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  ApiProvider apiProvider;
  List societies = [];
  List<String> societyNames = [];
  var file_to_display = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    partnerDetails = [];
    getSocieties();
  }

  Future chooseFromFileStorage() async {
    String file = await FilePicker.getFilePath();
    print(file.toString());
    setState(() {});
  }

  getSocieties() async {
    apiProvider = ApiProvider();
    societies = await apiProvider.getSocieties();
    if (mounted) {
      setState(() {
        print(societies);
        for (var i in societies) {
          print(i['name']);
          societyNames.add(i['name']);
        }
      });
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
              side: BorderSide(color: Colors.black)),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ListTile(
                          title: TextFormField(
                            controller: memberNameController,
                            decoration: InputDecoration(
                                labelText: "Full Name",
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                        ),
                        ListTile(
                          title: TextFormField(
                            controller: mobileNumberController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10)
                            ],
                            decoration: InputDecoration(
                                labelText: "Mobile Number",
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                        ),
                        ListTile(
                          title: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () {
                                setState(() {
                                  partnerDetails.add({
                                    'name': memberNameController.text,
                                    'mobileNumber': mobileNumberController.text,
                                    'email': emailController.text
                                  });
                                  Navigator.pop(context);
                                });
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.black)),
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
                                  side: BorderSide(color: Colors.black)),
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
            "Add Partner Details",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        );
      },
    ).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Tenant/Rent Registration ",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [Colors.blue[400], Colors.blue[400]])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15.0),
                                        topRight: Radius.circular(15.0)),
                                  ),
                                  builder: (context) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          leading: Icon(Icons.collections),
                                          title:
                                              Text('Choose From File Storage'),
                                          onTap: () async {
                                            String file =
                                                await FilePicker.getFilePath();
                                            print("something" + file);
                                            setState(() {
                                              file_to_display = file.toString();
                                            });
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Text(
                              "Upload Rent Agreement",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black)),
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: file_to_display == ''
                                    ? Center(
                                        child: Icon(Icons.queue),
                                      )
                                    : PdfViewer(
                                        filePath: file_to_display,
                                      )),
                          ),
                        ],
                      ),
                      ListTile(
                        title: DropdownButton<String>(
                          value: dropdownValueSocietyType,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                          iconSize: 0.0,
                          elevation: 16,
                          hint: Text(
                            "Society/Apartment",
                            style:
                                TextStyle(color: Colors.black, fontSize: 15.0),
                          ),
                          underline: Container(
                            height: 1,
                            color: Colors.black,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueSocietyType = newValue;
                            });
                          },
                          items: societyNames
                              .map<DropdownMenuItem<String>>((String value) {
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
                      ListTile(
                        title: TextFormField(
                          onChanged: tenantBloc.getUserOwnerName,
                          decoration: InputDecoration(
                              labelText: "Owner Name",
                              labelStyle: TextStyle(
                                color: Colors.black,
                              )),
                        ),
                      ),
                      ListTile(
                        title: DropdownButton<String>(
                          value: dropdownValueFlat,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                          iconSize: 0.0,
                          elevation: 16,
                          hint: Text(
                            "Flat Number",
                            style:
                                TextStyle(color: Colors.black, fontSize: 15.0),
                          ),
                          underline: Container(
                            height: 1,
                            color: Colors.black,
                          ),
                          onChanged: (String newValue) {},
                          items: <String>[
                            "C-501",
                            "C-502",
                            "C-503",
                            "C-504",
                            "C-505"
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
                      ListTile(
                        title: TextFormField(
                          onChanged: tenantBloc.getUserMobileNumber,
                          decoration: InputDecoration(
                              labelText: "Mobile Number",
                              labelStyle: TextStyle(
                                color: Colors.black,
                              )),
                        ),
                      ),
                      ListTile(
                        title: TextFormField(
                          onChanged: tenantBloc.getUserEmail,
                          decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(
                                color: Colors.black,
                              )),
                        ),
                      ),
                      ListTile(
                        title: TextFormField(
                          obscureText: true,
                          onChanged: tenantBloc.getUserPassword,
                          decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                color: Colors.black,
                              )),
                        ),
                      ),
                      ListTile(
                        trailing: IconButton(
                          onPressed: () {
                            dialogBoxFamilyDetails();
                          },
                          tooltip: "Add Family Details",
                          icon: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 25.0,
                          ),
                        ),
                        title: Text(
                          "Partner Details",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: partnerDetails.length == 0
                                  ? 0
                                  : partnerDetails.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Name:" +
                                          partnerDetails[index]['name']
                                              .toString()),
                                      Text("Mobile Nmber:" +
                                          partnerDetails[index]['mobileNumber']
                                              .toString()),
                                      Text("Email:" +
                                          partnerDetails[index]['email']
                                              .toString()),
                                    ],
                                  ),
                                );
                              })),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: RaisedButton(
              color: Colors.white,
              onPressed: () {
                tenantBloc.userCategory.value = dropdownValueSocietyType;

                tenantBloc.userFlatNumber.value = dropdownValueFlat;
                tenantBloc.tenantRegistration();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.black, width: 2.0)),
              child: Text(
                "Register",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
