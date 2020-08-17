import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:societyappresidents/repositories/Repository.dart';

class VisitorBloc {
  Repository repository = Repository();
  final visitorName = BehaviorSubject<String>();
  final visitorNumber = BehaviorSubject<String>();
  final numberOfPersons = BehaviorSubject<String>();

  Function(String) get getVisitorName => visitorName.sink.add;
  Function(String) get getVisitorNumber => visitorNumber.sink.add;
  Function(String) get getNumberOfPersons => numberOfPersons.sink.add;

  visitorDetails() {
    return repository.visitorDetails(
        visitorName.value, visitorNumber.value, numberOfPersons.value);
  }

  getVisitorDetails() {
    return repository.getVisitorDetails();
  }

  dispose() {
    visitorName.close();
    visitorNumber.close();
    numberOfPersons.close();
  }
}

final visitorBloc = VisitorBloc();
