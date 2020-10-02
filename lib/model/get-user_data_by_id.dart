import 'dart:convert';

import 'package:http/http.dart'as http;

class getData{
  Future <bool> getDataId(deviceId)async{
    var url='https://skytech-5d5eb.firebaseio.com/users.json';
    var response=await http.get(url);
    print(response.body+"response checked");
    var deviceidcheck=false;
    Map<String,dynamic> data=jsonDecode(response.body);
    data.forEach((key, value) {
      if(value['deviceid']==deviceId){
        deviceidcheck=true;
      }
    });
    return deviceidcheck;

  }
}