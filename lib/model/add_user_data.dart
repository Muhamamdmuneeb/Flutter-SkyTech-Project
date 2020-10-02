import 'dart:convert';

import 'package:http/http.dart'as http;

class addData{
  Future<int> addUserData(data)async{
    var url='https://skytech-5d5eb.firebaseio.com/users.json';
    var response=await http.post(url,body: jsonEncode(data));
    return response.statusCode;
  }
}