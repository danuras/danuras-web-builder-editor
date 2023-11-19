class CardBox {
  late int id;
  late String cardType, title, info;
  CardBox.fromJson(Map<String, dynamic> json) {
    cardType = json['card_type'];
    title = json['title'];
    info = json['info'];
    id = json['id'];
  }
}
