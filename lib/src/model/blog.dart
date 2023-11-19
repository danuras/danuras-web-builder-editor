class Blog {
  late int id;
  late String title, imageUrl, datePublished, author, link, text;
  Blog.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    imageUrl = json['image_url'];
    datePublished = json['date_published'];
    author = json['author'];
    link = json['link'];
    text = json['text'];
    id = json['id'];
  }
}
