class EmailService {
  late String name, emailSender,  password, emailReceiver;
  EmailService.fromJson(Map<String, dynamic> json){
    name = json['name'];
    emailSender = json['email_sender'];
    password = json['password'];
    emailReceiver = json['email_receiver'];
  }

  Map<String, String> toJson()=>{
    'name' : name,
    'email_sender' : emailSender,
    'password' : password,
    'email_receiver' : emailReceiver,
  };
}