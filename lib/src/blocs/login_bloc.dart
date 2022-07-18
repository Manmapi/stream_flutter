import 'dart:async';

import '../validators/validation.dart';

class LoginBloc{
  StreamController _emailController = StreamController();
  StreamController _passController = StreamController();

  Stream get emailStream => _emailController.stream;
  Stream get passStream => _passController.stream;

  bool isValidInfo(String email, String pass){
    bool flag = true;
    if(!Validation.isValidEmail(email))
      {
        print("Error in email");
        _emailController.sink.addError('Invalid Email');
          flag = false;
      }
    else
      {
        _emailController.sink.add("ok");
      }
    if(!Validation.isValidPass(pass))
      {
        print("Error in pass");
        _passController.sink.addError('Password must longer than 8 characters');
        flag = false;
      }
    else{
      _passController.sink.add("ok");
    }

    return flag;
  }
  void dispose(){
    print('bloc disposed');
    _emailController.close();
    _passController.close();
}
}