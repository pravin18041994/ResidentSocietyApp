import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:societyappresidents/models/ComplaintsModel.dart';
import 'package:societyappresidents/repositories/Repository.dart';

class RaiseComplaintBloc {
  var resp;
  Repository repository = Repository();

  final subject = BehaviorSubject<String>();
  final message = BehaviorSubject<String>();
  final image = BehaviorSubject<File>();
  final comment = BehaviorSubject<String>();
  final id = BehaviorSubject<String>();

  Function(String) get getSubject => subject.sink.add;
  Function(String) get getMessage => message.sink.add;
  Function(File) get getImage => image.sink.add;
  Function(String) get getComment => comment.sink.add;
  Function(String) get getId => id.sink.add;

  Future<String> raiseComplaint() async {
    resp = await repository.raiseComplaint(
        subject.value, message.value, image.value);
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<List<ComplaintsModel>> getComplaints() async {
    return repository.getPastComplaints();
  }

  Future<String> postCommentDiscussion() async {
    return repository.postCommentDiscussion(comment.value, id.value);
  }

  dispose() {
    subject.close();
    message.close();
    image.close();
    comment.close();
    id.close();
  }
}

final raiseComplaintBloc = RaiseComplaintBloc();
