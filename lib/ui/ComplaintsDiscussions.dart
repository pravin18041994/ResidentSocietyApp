import 'package:flutter/material.dart';
import 'package:societyappresidents/bloc/RaiseComplaintBloc.dart';

class ComplaintsDiscussions extends StatefulWidget {
  final List listDiscussions;
  final String id;

  ComplaintsDiscussions(this.listDiscussions, this.id);

  @override
  _ComplaintsDiscussionsState createState() => _ComplaintsDiscussionsState();
}

class _ComplaintsDiscussionsState extends State<ComplaintsDiscussions> {
  TextEditingController msgController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var resp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.blue[400],
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            "Complaints Discusssions",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Expanded(
                    child:

                        // ListView.builder(
                        //       itemCount: widget.listDiscussions.length,
                        //       itemBuilder: (context, index) {
                        //         return Container(
                        //           child: sharedPreferences.getString('name') ==
                        //                   messages[index]['user_name']
                        //               ? Column(
                        //                   children: <Widget>[
                        //                     Row(
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment.end,
                        //                       children: <Widget>[
                        //                         Container(
                        //                           margin:
                        //                               EdgeInsets.only(right: 10.0),
                        //                           child: Chip(
                        //                             avatar: CircleAvatar(
                        //                               backgroundColor:
                        //                                   Colors.grey.shade800,
                        //                               child: Text(
                        //                                 messages[index]['user_name']
                        //                                         .split(' ')[0][0] +
                        //                                     messages[index]
                        //                                             ['user_name']
                        //                                         .split(' ')[1][0],
                        //                                 style: TextStyle(
                        //                                     fontSize: 13.0),
                        //                               ),
                        //                             ),
                        //                             label: Text(messages[index]
                        //                                     ['user_name']
                        //                                 .toString()),
                        //                           ),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                     Row(
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment.end,
                        //                       children: <Widget>[
                        //                         Container(
                        //                           width: MediaQuery.of(context)
                        //                                   .size
                        //                                   .width *
                        //                               0.8,
                        //                           margin:
                        //                               EdgeInsets.only(right: 10.0),
                        //                           child: Text(
                        //                             messages[index]['message'],
                        //                             style: TextStyle(
                        //                               color: Colors.white,
                        //                               fontWeight: FontWeight.bold,
                        //                             ),
                        //                             textAlign: TextAlign.end,
                        //                           ),
                        //                         ),
                        //                       ],
                        //                     )
                        //                   ],
                        //                 )
                        //               : Column(
                        //                   children: <Widget>[
                        //                     Row(
                        //                       children: <Widget>[
                        //                         Container(
                        //                           margin:
                        //                               EdgeInsets.only(left: 10.0),
                        //                           child: Chip(
                        //                             avatar: CircleAvatar(
                        //                               backgroundColor:
                        //                                   Colors.grey.shade800,
                        //                               child: Text(
                        //                                 messages[index]['user_name']
                        //                                         .split(' ')[0][0] +
                        //                                     messages[index]
                        //                                             ['user_name']
                        //                                         .split(' ')[1][0],
                        //                                 style: TextStyle(
                        //                                     fontSize: 13.0),
                        //                               ),
                        //                             ),
                        //                             label: Text(messages[index]
                        //                                     ['user_name']
                        //                                 .toString()),
                        //                           ),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                     Row(
                        //                       children: <Widget>[
                        //                         Container(
                        //                           width: MediaQuery.of(context)
                        //                                   .size
                        //                                   .width *
                        //                               0.8,
                        //                           margin: EdgeInsets.only(
                        //                               left: 10.0, right: 10.0),
                        //                           child: Text(
                        //                             messages[index]['message'],
                        //                             style: TextStyle(
                        //                                 color: Colors.white,
                        //                                 fontWeight:
                        //                                     FontWeight.bold),
                        //                           ),
                        //                         ),
                        //                       ],
                        //                     )
                        //                   ],
                        //                 ),
                        //         );
                        //       },
                        //       shrinkWrap: true,
                        //     ),

                        ListView.builder(
                            itemCount: widget.listDiscussions.length,
                            itemBuilder: (ctx, index) {
                              return Container(
                                height: 40,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        widget.listDiscussions[index]['message']
                                            .toString(),
                                        textAlign: widget.listDiscussions[index]
                                                    ['user'] ==
                                                "me"
                                            ? TextAlign.end
                                            : TextAlign.start),
                                  ),
                                ),
                              );
                            })),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: msgController,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    raiseComplaintBloc.dialogLoader(context);
                                    raiseComplaintBloc.comment.value =
                                        msgController.text;
                                    raiseComplaintBloc.id.value = widget.id;
                                    resp = await raiseComplaintBloc
                                        .postCommentDiscussion();
                                    if (resp == 'success') {
                                      Navigator.pop(context);
                                      _scaffoldKey.currentState.showSnackBar(
                                          new SnackBar(
                                              content: new Text(
                                                  "Comment Posted Successfully !",
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
                                  },
                                  icon: Icon(Icons.send, color: Colors.black),
                                ),
                                hintText: "Type Here",
                                hintStyle: TextStyle(color: Colors.black)),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )));
  }
}
