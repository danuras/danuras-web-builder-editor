class SocialMediaModel {
  late String? facebook, twitter, linkedin, instagram, googlePlus, youtube;
  SocialMediaModel.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'];
    twitter = json['twitter'];
    linkedin = json['linkedin'];
    instagram = json['instagram'];
    googlePlus = json['google_plus'];
    youtube = json['youtube'];
  }
}
