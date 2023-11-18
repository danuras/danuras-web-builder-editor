class CompanyProfile {
  late String description, imageUrl, whatsappMessage, mission, vision;
  CompanyProfile.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    whatsappMessage = json['whatsapp_message'];
    imageUrl = json['image_url'];
    mission = json['mission'];
    vision = json['vision'];
  }
}
