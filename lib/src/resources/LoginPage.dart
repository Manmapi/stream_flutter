import 'package:flutter/material.dart';

import '../blocs/login_bloc.dart';


class LoginPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}
class _LoginPageState extends State<LoginPage>
{

  LoginBloc bloc = LoginBloc();
  String _email = '';
  String _pass = '';
  bool _isShow = true;
  String _passwordOption = "SHOW";
  @override
  void initState()
  {
    print("Init");
    super.initState();
  }
  @override
  void dispose(){
    print("Login dispose");
    bloc.dispose();
    super.dispose();
  }
  @override
  void deactivate()
  {
    print("deactivate");
    super.deactivate();
    dispose();
  }
  @override
  Widget build(BuildContext context)
  {

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
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hello',style:const TextStyle(fontSize: 60),),
                            Text('Welcome Back',style:const TextStyle(fontSize: 40,fontWeight: FontWeight.w700))
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: StreamBuilder(
                                stream: bloc.emailStream,
                                builder: (context,snapshot) =>TextField(
                                onChanged: (String value) {
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
                                            _passwordOption = _isShow?'SHOW':'HIDE';
                                          });
                                        },
                                        child: Text( _passwordOption,style:const TextStyle(color: Colors.blueAccent,fontSize: 15,fontWeight: FontWeight.w600),)),
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
                        child: ElevatedButton(
                            style:ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)
                                ))
                            ),
                            onPressed: (){
                              bool data= bloc.isValidInfo(_email, _pass);
                              if(data)
                                {
                                  Navigator.pushNamed(context, '/home');
                                }

                            },
                            child:const Text('SIGN IN',style: TextStyle(fontSize: 20,color: Colors.white),)),
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


