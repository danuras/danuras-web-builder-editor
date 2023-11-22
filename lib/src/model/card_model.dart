class CardModel {
  late int id, cardBoxId;
  late String? imageUrl, title, contentType, text, link;
  late bool isClickable;
  CardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardBoxId = json['card_box_id'];
    imageUrl = json['image_url'];
    title = json['title'];
    contentType = json['content_type'];
    isClickable = (json['is_clickable'] == 1);
    text = json['text'];
    link = json['link'];
  }
}
