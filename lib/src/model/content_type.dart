class ContentType {
  late int? id, cardTypeId;
  late String? imageUrl;
  late String? title, text;
  ContentType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardTypeId = json['card_type_id'].runtimeType == String?int.parse(json['card_type_id']):json['card_type_id'];
    imageUrl = json['image_url'];
    title = json['title'];
    text = json['text'];
  }
}
