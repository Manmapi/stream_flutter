import 'dart:async';

import '../validators/validation.dart';

class LoginBloc{
  StreamController _emailController = StreamController.broadcast();
  StreamController _passController = StreamController.broadcast();
  StreamController _userController = StreamController();

  Stream get emailStream => _emailController.stream;
  Stream get passStream => _passController.stream;
  Stream get userStream => _userController.stream;
  bool isValidInfo(String email, String pass){
    bool flag = true;
    if(!Validation.isValidEmail(email))
      {
        _emailController.sink.addError('Invalid Email');
          flag = false;
      }
    else
      {
        _emailController.sink.add("ok");
      }
    if(!Validation.isValidPass(pass))
      {
        _passController.sink.addError('Password must longer than 6 characters');
        flag = false;
      }
    else{
      _passController.sink.add("ok");
    }

    return flag;
  }
  bool isValidUser (authRes)
  {

    if((authRes['statusCode']/100).floor()!=4)
      {
        return true;
      }
    else{
      _userController.sink.addError(authRes['body']['message'].toString());
      return false;
    }
  }
  void dispose(){
    _emailController.close();
    _passController.close();
}
}