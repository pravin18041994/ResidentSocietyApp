import 'package:rxdart/subjects.dart';
import 'package:societyappresidents/repositories/Repository.dart';

class TenantBloc {
  Repository repository = Repository();
  final userCategory = BehaviorSubject<String>();
  final userPassword = BehaviorSubject<String>();
  final userOwnerName = BehaviorSubject<String>();
  final userFlatNumber = BehaviorSubject<String>();
  final userMobileNumber = BehaviorSubject<String>();
  final userEmail = BehaviorSubject<String>();

  Function(String) get getUserCategory => userCategory.sink.add;
  Function(String) get getUserPassword => userPassword.sink.add;
  Function(String) get getUserOwnerName => userOwnerName.sink.add;
  Function(String) get getUserFlatNumber => userFlatNumber.sink.add;
  Function(String) get getUserMobileNumber => userMobileNumber.sink.add;
  Function(String) get getUserEmail => userEmail.sink.add;

  tenantRegistration() {
    repository.tenantRegistration(
        userCategory.value,
        userPassword.value,
        userOwnerName.value,
        userFlatNumber.value,
        userMobileNumber.value,
        userEmail.value);
  }

  dispose() {
    userCategory.close();
    userPassword.close();
    userOwnerName.close();
    userFlatNumber.close();
    userMobileNumber.close();
    userEmail.close();
  }
}

final tenantBloc = TenantBloc();
