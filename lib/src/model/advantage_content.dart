class AdvantageContent {
  late int id;
  late String icon, title, text;
  AdvantageContent.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
    text = json['text'];
    id = json['id'];
  }
}
