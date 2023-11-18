class User {
  late int id;
  late String email;
  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    email = json['email'];
  }

}