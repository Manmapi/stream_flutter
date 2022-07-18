import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intro_stream/src/API/studentAPI.dart';
class HomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: WillPopScope(
          onWillPop:  () async  { await  SystemNavigator.pop();
            return false;},
          child: Center(child: FutureBuilder(
              future: studentAPI.getStudent(),
              builder:(context, AsyncSnapshot snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting)
                  {
                    return Text("Loading");
                  }
                else{
                   return Text(snapshot.data[4]["name"].toString());
                }
              }),)),
    );
  }
}