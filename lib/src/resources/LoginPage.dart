import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../API/authAPI.dart';
import '../blocs/login_bloc.dart';
import '../local_storage/login_token.dart';



class LoginPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}
class _LoginPageState extends State<LoginPage>
{
    getToken () async {
      var token  = await UserToken.getToken();
      if(token!= null)
        {
          Navigator.pushNamed(context, "/home");
      }
    return false;
  }
  String _token ='';
  var authentical = authAPI();
  LoginBloc bloc = LoginBloc();
  String _email = '';
  String _pass = '';
  bool _isShow = true;
  bool _isLoading = false;
  @override

  @override
   Widget   build  (BuildContext context)
  {
    getToken();

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body:  Container(
          decoration:const BoxDecoration(
              color: Colors.white
          ),
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
            child:GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
              child: Container(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 150,
                      ),
                      Image.asset('assets/login.png',
                        width: 80,
                        height: 80,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Hello",style:const TextStyle(fontSize: 60),),
                            Text('Welcome Back',style:const TextStyle(fontSize: 40,fontWeight: FontWeight.w700))
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            child: StreamBuilder(
                              stream: bloc.userStream,
                              builder: (context,snapshot)=>Text(
                                snapshot.hasError? snapshot.error.toString(): "",
                                style: TextStyle(color:Colors.red,fontStyle: FontStyle.italic, fontSize: 15),
                              ),
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: StreamBuilder(
                                stream: bloc.emailStream,
                                builder: (context,snapshot) =>TextField(
                                onChanged: (String value) {
                                  bloc.isValidInfo(_email, _pass);
                                  _email = value;

                                },
                                style:const TextStyle(
                                  fontSize: 20,
                                  decoration: TextDecoration.none,
                                ),
                                decoration: InputDecoration(
                                  errorText: snapshot.hasError&&(!snapshot.hasData)?snapshot.error.toString():null,
                                  errorStyle: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
                                  labelText: 'EMAIL',
                                  labelStyle:const TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.w500),
                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                ),
                              ),)
                          ),
                          Container(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 60),
                              child: StreamBuilder(
                                stream: bloc.passStream,
                                builder: (context,snapshot)=>TextField(
                                  onChanged: (String value) {
                                    bloc.isValidInfo(_email, _pass);
                                    _pass = value;

                                  },
                                  style:const TextStyle(
                                    fontSize: 20,
                                  ),
                                  obscureText: _isShow,
                                  decoration: InputDecoration(
                                    errorText: snapshot.hasError&&(!snapshot.hasData)?snapshot.error.toString():null,
                                    errorStyle: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
                                    suffix: GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            _isShow=!_isShow;
                                          });
                                        },
                                        child: Text( _isShow?'SHOW':'HIDE',style:const TextStyle(color: Colors.blueAccent,fontSize: 15,fontWeight: FontWeight.w600),)),
                                    labelText: 'PASSWORD',
                                    labelStyle:const TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.w500),
                                    floatingLabelBehavior:  FloatingLabelBehavior.auto,

                                  ),
                                ),
                              )
                              ),
                        ],
                      ),
                      Container(
                        height:50 ,
                        width:double.infinity ,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child:ElevatedButton(
                            style:ButtonStyle(
                                backgroundColor: _isLoading?MaterialStateProperty.all(Colors.green):MaterialStateProperty.all(Colors.blue),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                ),
                                ),
                            ),
                            onPressed:_isLoading?(){}:() async {
                              bool data= bloc.isValidInfo(_email, _pass);
                              if(data)
                                {
                                  setState(() {
                                    _isLoading =true;
                                  });
                                  var authRes =await authentical.register({
                                    'email':_email,
                                    'password':_pass,
                                  });
                                  setState(() {
                                    _isLoading =false;
                                  });
                                  if(bloc.isValidUser(authRes))
                                  {
                                    UserToken.setToken(authRes["body"]["token"].toString());
                                    Navigator.pushNamed(context, '/home');
                                  }
                                }

                            },
                            child:Text(
                            _isLoading ?'SIGNING IN...':'SIGN IN',
                              style: TextStyle(fontSize: 20,color: Colors.white,),)),

                      ) ,
                      Container(
                        padding:const EdgeInsets.fromLTRB(0, 90, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text('NEW USER? ',style:const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500)),
                                const Text('SIGN UP',style:const TextStyle(color: Colors.blue,fontSize: 15,fontWeight: FontWeight.w500)),
                              ],
                            ),
                            const Text('FORGOT PASSWORD?',style: TextStyle(color: Colors.blue,fontSize: 15,fontWeight: FontWeight.w500),)
                          ],
                        ),
                      )


                    ],
                  ),
                ),
              ),
            ),),
        )
    );
  }

}


