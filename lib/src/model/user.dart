class User {
  late int id;
  late String email;
  late bool isPrimary;
  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    email = json['email'];
    isPrimary = json['is_primary']==1;
  }

}