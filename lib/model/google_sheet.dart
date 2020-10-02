class FeedbackForm {
  String firstname;
  String lastname;
  String employee_id;
  String device_id;
  String clockin_date;
  String clockin_time;
  String clockin_latitude;
  String clockin_longtitude;
  String clockout_date;
  String clockout_time;
  String clockout_latitude;
  String clockout_longtitude;


  FeedbackForm(this.firstname,this.lastname,this.employee_id,this.device_id,this.clockin_time,this.clockin_date,this.clockin_latitude,this.clockin_longtitude,this.clockout_date,this.clockout_time,this.clockout_latitude,this.clockout_longtitude);
  String toParams() =>
      "?firstname=$firstname&lastname=$lastname&employee_id=$employee_id&device_id=$clockin_date&clockin_date=$clockin_time&clockin_time=$device_id&clockin_latitude=$clockin_latitude&clockin_longtitude=$clockin_longtitude&clockout_date=$clockout_date&clockout_time=$clockout_time&clockout_latitude=$clockout_latitude&clockout_longtitude=$clockout_longtitude";


  // Method to make GET parameters.

}