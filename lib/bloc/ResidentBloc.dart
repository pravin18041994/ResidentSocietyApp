import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:societyappresidents/provider/ApiProvider.dart';
import 'package:societyappresidents/repositories/Repository.dart';

class ResidentBloc {
  Repository repository = Repository();
  final userCategory = BehaviorSubject<String>();
  final userPassword = BehaviorSubject<String>();
  final userOwnerName = BehaviorSubject<String>();
  final userFlatNumber = BehaviorSubject<String>();
  final userMobileNumber = BehaviorSubject<String>();
  final userEmail = BehaviorSubject<String>();
  final society = BehaviorSubject<String>();
  final familyDetails = BehaviorSubject<String>();

  Function(String) get getUserCategory => userCategory.sink.add;
  Function(String) get getUserPassword => userPassword.sink.add;
  Function(String) get getUserOwnerName => userOwnerName.sink.add;
  Function(String) get getUserFlatNumber => userFlatNumber.sink.add;
  Function(String) get getUserMobileNumber => userMobileNumber.sink.add;
  Function(String) get getUserEmail => userEmail.sink.add;
  Function(String) get getSociety => society.sink.add;
  Function(String) get getFamilyDetails => familyDetails.sink.add;

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

  residentRegister() {
    Future<String> resp;
    resp = repository.residentRegistration(
        userCategory.value,
        userOwnerName.value,
         userFlatNumber.value,
        userMobileNumber.value,
        userEmail.value,
        userPassword.value,
        society.value,
        familyDetails.value);
        return resp;
  }

  dispose() {
    userCategory.close();
    userPassword.close();
    userOwnerName.close();
    userFlatNumber.close();
    userMobileNumber.close();
    userEmail.close();
    society.close();
    familyDetails.close();
  }
  getFlats(id) async {
    ApiProvider apiProvider = new ApiProvider();
    return await apiProvider.getFlats(id);
  }
  
}

final residentBloc = ResidentBloc();
