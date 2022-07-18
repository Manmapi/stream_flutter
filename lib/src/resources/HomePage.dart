import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/services.dart';
class HomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: WillPopScope(
          onWillPop:  () async  { await  SystemNavigator.pop();
            return false;},
          child: Center(child: Text("Something"),)),
    );
  }
}