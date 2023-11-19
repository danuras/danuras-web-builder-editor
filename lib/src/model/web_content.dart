class WebContent {
  late int id, rank;
  int? cardBoxId;
  late String contentType;
  WebContent.fromJson(Map<String, dynamic> json) {
    contentType = json['content_type'];
    cardBoxId = json['card_box_id'];
    id = json['id'];
    rank = json['rank'];
  }
}
