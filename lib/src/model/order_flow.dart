class OrderFlow {
  late int id;
  late String icon, value;
  OrderFlow.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    value = json['value'];
  }
}
