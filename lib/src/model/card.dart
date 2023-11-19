class Card {
  late int id, cardBoxId;
  late String? imageUrl, title, contentType, isClickable, text, link;
  Card.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardBoxId = json['card_box_id'];
    imageUrl = json['image_url'];
    title = json['title'];
    contentType = json['content_type'];
    isClickable = json['is_clickable']??false;
    text = json['text'];
    link = json['link'];
  }
}
