import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:skytech/model/google_sheet.dart';


class FormController {
  // Callback function to give response of status of current request.
  final void Function(String) callback;

  // Google App Script Web URL
  static const String URL = "https://script.google.com/macros/s/AKfycbwwX1jyt-mC3OWbAVe8021oRtOC1ZqUwCxZdpAdfxVvYR94wCQ/exec";

  static const STATUS_SUCCESS = "SUCCESS";

  FormController(this.callback);

  void submitForm(FeedbackForm feedbackForm) async{
    try{
      print("check1");
      await http.post(URL + feedbackForm.toParams()).then(
              (response){
            callback(convert.jsonDecode(response.body)['status']);
            print(convert.jsonDecode(response.body)+" body");
          });
    } catch(e){
      print(e);
      print(e.toString()+" error in controller");
    }
  }
}