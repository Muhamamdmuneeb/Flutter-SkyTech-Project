import 'dart:convert';

import 'package:http/http.dart'as http;

class getId{
  Future <Map> getid(deviceId)async{
    var url='https://skytech-5d5eb.firebaseio.com/users.json';
    var response=await http.get(url);
    Map<String,dynamic> data1;
    Map<String,dynamic> data=jsonDecode(response.body);
    print("user response"+data.toString());
    data.forEach((key, value) {
      if(value['deviceid']==deviceId){
        print("print in print");
        data1={
          'firstname':value['firstname'],
          'lastname':value['lastname'],
          'empid':value['empid'],
          'deviceid':value['deviceid'],
        };

      }
    });
    print("print check 1"+data1.toString());
    if(data1!=null){
      return data1;
    }else{return null;}

  }
}