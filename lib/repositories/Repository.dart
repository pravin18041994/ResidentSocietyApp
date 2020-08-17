import 'dart:io';
import 'package:societyappresidents/models/ComplaintsModel.dart';
import 'package:societyappresidents/provider/ApiProvider.dart';

class Repository {
  ApiProvider apiProvider = ApiProvider();
  Future<String> login(var userContactNumber, var userPassword) =>
      apiProvider.login(userContactNumber, userPassword);

  Future<void> tenantRegistration(
          var userCategory,
          var userType,
          var userFlatNumber,
          var userOwnerName,
          var userMobileNumber,
          var userEmail) =>
      apiProvider.tenantRegistration(userCategory, userType, userFlatNumber,
          userOwnerName, userEmail, userMobileNumber);

  Future<String> residentRegistration(
          var userType,
          var userOwnerName,
          var userFlatNumber,
          var userMobileNumber,
          var userEmail,
          var password,
          var society,
          var familyDetails) =>
      apiProvider.residentRegistration(userType, userOwnerName, userFlatNumber,
          userMobileNumber, userEmail, password, society, familyDetails);

  Future<String> updateResidentDetails(
          var userType,
          var userOwnerName,
          var userFlatNumber,
          var userMobileNumber,
          var userEmail,
          var society,
          var familyDetails) =>
      apiProvider.updateResidentDetails(userType, userOwnerName, userFlatNumber,
          userMobileNumber, userEmail, society, familyDetails);

  Future<String> raiseComplaint(var subject, var message, File image) =>
      apiProvider.raiseComplaint(subject, message, image);

  Future<String> changePasswordGetContact(var contact) =>
      apiProvider.changePasswordGetContact(contact);
  //Change Password Verify OTP
  Future<String> changePasswordVerifyOTP(var contact, var otp) =>
      apiProvider.changePasswordVerifyOTP(contact, otp);
  //Change Password Confirmation
  Future<String> changePasswordConfirmation(var contact, var password) =>
      apiProvider.changePasswordConfirmation(contact, password);

  Future<void> getProfileDetails() => apiProvider.getProfileDetails();
  Future<List<ComplaintsModel>> getPastComplaints() =>
      apiProvider.getPastComplaints();
  Future<String> postCommentDiscussion(var comment, var id) =>
      apiProvider.postCommentDiscussion(comment, id);

  Future<String> visitorDetails(
          var visitorName, var visitorNumber, var noOfPersons) =>
      apiProvider.addVisitorDetails(visitorName, visitorNumber, noOfPersons);

  Future<List> getVisitorDetails() => apiProvider.getVisitorDetails();
}
