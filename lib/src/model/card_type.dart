class CardType {
  late int id, cardId;
  late String? imageUrl, title, whatsappMessage, subContentTitle, text;
  CardType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardId = json['card_id'];
    imageUrl = json['image_url'];
    title = json['title'];
    whatsappMessage = json['whatsapp_message'];
    subContentTitle = json['sub_content+title'];
    text = json['text'];
  }
}
