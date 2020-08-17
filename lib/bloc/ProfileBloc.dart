import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:societyappresidents/provider/ApiProvider.dart';
import 'package:societyappresidents/repositories/Repository.dart';

class ProfileBloc {
  Repository repository = Repository();
  final societyType = BehaviorSubject<String>();
  final ownerName = BehaviorSubject<String>();
  final flatNumber = BehaviorSubject<String>();
  final mobileNumber = BehaviorSubject<String>();
  final email = BehaviorSubject<String>();
  final familyDetails = BehaviorSubject<List>();
  final id = BehaviorSubject<String>();
  final society = BehaviorSubject<String>();
  final familyDetailString = BehaviorSubject<String>();

  Function(String) get getSocietyType => societyType.sink.add;
  Function(String) get getOwnerName => ownerName.sink.add;
  Function(String) get getFlatNumber => flatNumber.sink.add;
  Function(String) get getMobileNumber => mobileNumber.sink.add;
  Function(String) get getEmail => email.sink.add;
  Function(List) get getFamilyDetails => familyDetails.sink.add;
  Function(String) get getId => id.sink.add;
  Function(String) get getSociety => society.sink.add;
  Function(String) get getFamilyDetailsString => familyDetailString.sink.add;

  profileDetails() {
    repository.getProfileDetails();
  }

  dispose() {
    societyType.close();
    ownerName.close();
    flatNumber.close();
    mobileNumber.close();
    email.close();
    familyDetails.close();
    id.close();
    society.close();
    familyDetailString.close();
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

  getFlats(id) async {
    ApiProvider apiProvider = new ApiProvider();
    return await apiProvider.getFlats(id);
  }

  updateResidentDetails() async {
    Future<String> resp;
    resp = repository.updateResidentDetails(        
        societyType.value,
        ownerName.value,
        flatNumber.value,
        mobileNumber.value,
        email.value,
        society.value,
        familyDetailString.value);
        return resp;
  }
}

final profilBloc = ProfileBloc();
