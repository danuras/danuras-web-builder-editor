class WebContent {
  late int id, rank;
  int? cardBoxId;
  String? cardType, title;
  late String contentType;
  WebContent.fromJson(Map<String, dynamic> json) {
    contentType = json['content_type'];
    title = json['title'];
    cardType = json['card_type'];
    cardBoxId = json['card_box_id'];
    id = json['id'];
    rank = json['rank'];
  }
}
