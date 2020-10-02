import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skytech/model/get_key_of_dataInfo.dart';
import 'package:skytech/pages/clockin.dart';
import 'package:skytech/pages/clockout.dart';

class ClockinCheck extends StatefulWidget {
  @override
  _ClockinCheckState createState() => _ClockinCheckState();
}

class _ClockinCheckState extends State<ClockinCheck> {
  var check;
  var key;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    checkkey();
  }
 checkkey()async{
    var  key1=await getUserKey().getUserKey1();
    setState(() {
      key=key1;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: key == null ? ClockIn(): ClockOut(checkdata: false,),);
  }
}