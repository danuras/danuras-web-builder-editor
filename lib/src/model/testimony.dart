class Testimony {
  late int id;
  late String value, photoProfile, name, job;
  Testimony.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    photoProfile = json['photo_profile'];
    name = json['name'];
    job = json['job'];
    id = json['id'];
  }
}
