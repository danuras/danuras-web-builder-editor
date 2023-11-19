class Advantage {
  late String title, description, imageUrl;
  Advantage.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    imageUrl = json['image_url'];
  }
}
