class WebAttribute {
  late String title, shortDescription,  longTitle, mainHeading, subHeading, backgroundImage;
  String? icon, backgroundTestimonies;
  WebAttribute.fromJson(Map<String, dynamic> json){
    title = json['title'];
    shortDescription = json['short_description'];
    longTitle = json['long_title'];
    mainHeading = json['main_heading'];
    subHeading = json['sub_heading'];
    backgroundImage = json['background_image'];
    icon = json['icon'];
    backgroundTestimonies = json['background_testimonies'];
  }
}