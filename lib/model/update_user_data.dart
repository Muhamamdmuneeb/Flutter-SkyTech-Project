import 'dart:convert';

import 'package:http/http.dart'as http;

class updateUserInfo{
  Future<int> updateUserData(key,data)async{
    var url='https://skytech-5d5eb.firebaseio.com/usersInfo/$key.json';
    var response=await http.patch(url,body: jsonEncode(data));
    return response.statusCode;
  }
}