import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:societyappresidents/bloc/RaiseComplaintBloc.dart';
import 'package:societyappresidents/models/ComplaintsModel.dart';
import 'package:societyappresidents/ui/ComplaintsDiscussions.dart';

class RaiseComplaint extends StatefulWidget {
  @override
  _RaiseComplaintState createState() => _RaiseComplaintState();
}

class _RaiseComplaintState extends State<RaiseComplaint> {
  var ImagePath;
  var img;
  var resp;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var isLoading = true;

  List<ComplaintsModel> complaints;

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      img = image;
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      img = image;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    complaints = [];

    getComplaints();
  }

  getComplaints() async {
    complaints = await raiseComplaintBloc.getComplaints();
    setState(() {
      isLoading = false;
      complaints = complaints;
    });
    //print('c'+complaints.toString());
  }

  Future<Null> getRefresh() async {
    try {
      getComplaints();
      await Future.delayed(Duration(seconds: 2));
    } catch (e) {
      // checkInternetConnection();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.blue[400],
        appBar: AppBar(
          backgroundColor: Colors.blue[400],
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "Complaint Details",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.directions_car),
                text: "Raise A Complaint",
              ),
              Tab(
                icon: Icon(Icons.directions_transit),
                text: "Past Complaints",
              )
            ],
          ),
        ),
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              )
            : TabBarView(
                children: [
                  ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ListTile(
                              title: TextFormField(
                                style: TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                onChanged: raiseComplaintBloc.getSubject,
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    labelText: "Subject",
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            ListTile(
                              title: TextFormField(
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                onChanged: raiseComplaintBloc.getMessage,
                                maxLines: 7,
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    labelText: "Message",
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.black)),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: img == null
                                    ? Center(
                                        child: Icon(Icons.queue),
                                      )
                                    : Image.file(
                                        img,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Center(
                              child: RaisedButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: BorderSide(color: Colors.black)),
                                onPressed: () {
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
                                                  Text('Choose From Gallery'),
                                              onTap: () {
                                                getImageFromGallery();
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ListTile(
                                              leading: Icon(Icons.camera_alt),
                                              title: Text('Take A Photo'),
                                              onTap: () {
                                                getImageFromCamera();
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: Text(
                                  "Pick Image",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: RaisedButton(
                                color: Colors.white,
                                onPressed: () async {
                                  print("Clicked");
                                  raiseComplaintBloc.dialogLoader(context);

                                  raiseComplaintBloc.image.value = img;
                                  resp =
                                      await raiseComplaintBloc.raiseComplaint();
                                  if (resp == 'success') {
                                    Navigator.pop(context);
                                    _scaffoldKey.currentState.showSnackBar(
                                        new SnackBar(
                                            content: new Text(
                                                "Complaint Raised Successfully !",
                                                style: TextStyle(
                                                    fontFamily: 'Raleway'))));
                                  } else {
                                    Navigator.pop(context);
                                    _scaffoldKey.currentState.showSnackBar(
                                        new SnackBar(
                                            content: new Text(
                                                "Please Try Again later !",
                                                style: TextStyle(
                                                    fontFamily: 'Ralweway'))));
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                        color: Colors.black, width: 2.0)),
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
                      ),
                    ],
                  ),

                  //Past Transactions
                  RefreshIndicator(
                    onRefresh: getRefresh,
                    child: complaints.length == 0
                        ? Center(child: Text("No complaints found !"))
                        : ListView.builder(
                            itemCount: complaints.length,
                            itemBuilder: (ctx, index) => Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        print(complaints[index].id.toString());
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (_) {
                                          return ComplaintsDiscussions(
                                              complaints[index].listDiscussions,
                                              complaints[index].id);
                                        }));
                                      },
                                      child: Card(
                                        semanticContainer: true,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                child: Image.network(
                                              'https://picsum.photos/200/300',
                                              fit: BoxFit.fill,
                                              width: 110,
                                            )),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Text(
                                                            complaints[index]
                                                                .subject
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blue),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                  )
                ],
              ),
      ),
    );
  }
}
