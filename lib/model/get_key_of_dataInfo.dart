import 'dart:convert';

import 'package:http/http.dart'as http;

class getUserKey{
  Future<String> getUserKey1()async{
    var url='https://skytech-5d5eb.firebaseio.com/usersInfo.json';
    var response=await http.get(url);
    Map<String,dynamic> data=jsonDecode(response.body);
    var key1;
    data.forEach((key, value) {
      if(value['check']==false){
        key1=key;
        return true;
      }
    });
    if(key1!=null){
      return key1;
    }else{
      return key1;
    }

  }
}