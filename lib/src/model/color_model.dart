class ColorModel {
  late String? headerTextColor, commonTextColor, backgroundColor1, backgroundColor2, cardColor, highlightColor;
  ColorModel.fromJson(Map<String, dynamic> json) {
    headerTextColor = json['header_text_color'];
    commonTextColor = json['common_text_color'];
    backgroundColor1 = json['background_color_1'];
    backgroundColor2 = json['background_color_2'];
    cardColor = json['card_color'];
    highlightColor = json['highlight_color'];
  }
}
